# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Zwave to Mqtt gateway and Control Panel Web UI."
HOMEPAGE="https://github.com/zwave-js/zwavejs2mqtt https://zwave-js.github.io/zwavejs2mqtt/#/"
SRC_URI="https://github.com/zwave-js/${MY_PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~amd64 ~arm ~arm64"

DEPEND="
	acct-group/zwavejs2mqtt
	acct-user/zwavejs2mqtt"

RDEPEND="
	${DEPEND}"

BDEPEND="
	net-libs/nodejs
	sys-apps/yarn
	virtual/pkgconfig
	extras? (
		app-doc/xmltoman
		app-text/htmldoc
		sys-devel/gettext
	)"

BUILD_DIR="${WORKDIR}/${MY_PN}-${PV}_build"
S="${WORKDIR}/${MY_PN}-${PV}"
MY_NODE_DIR="${S}/${MY_PN}/"

src_prepare() {
	cmake_src_prepare
	# We will use pre-generated npm stuff.
	mv "${WORKDIR}/${MY_NODE_N}" "${MY_NODE_DIR}" || die "couldn't move node_modules"
	# Update .yarnrc accordingly.
	echo "--modules-folder ${MY_NODE_DIR}" >> "${S}/${MY_PN}/.yarnrc" || die "echo failed"
	# QA-Fix | Remove !CLANG doxygen warnings for 9.0.0
	if use extras; then
		if ! tc-is-clang; then
		   local f
		   for f in gsad/doc/*.in
		   do
			sed -i \
				-e "s*CLANG_ASSISTED_PARSING = NO*#CLANG_ASSISTED_PARSING = NO*g" \
				-e "s*CLANG_OPTIONS*#CLANG_OPTIONS*g" \
				"${f}" || die "couldn't disable CLANG parsing"
		   done
		fi
	fi
}

src_configure() {
	local mycmakeargs=(
		"-DLOCALSTATEDIR=${EPREFIX}/var"
		"-DSYSCONFDIR=${EPREFIX}/etc"
		"-DSBINDIR=${EPREFIX}/usr/bin"
		"-DGSAD_PID_DIR=${EPREFIX}/run/"
		"-DDEFAULT_CONFIG_DIR=${EPREFIX}/etc/default"
		"-DLOGROTATE_DIR=${EPREFIX}/etc/logrotate.d"
	)
	cmake_src_configure
}

src_compile() {
	# setting correct PATH for finding react-js
	NODE_ENV=production PATH="$PATH:${S}/gsa/node_modules/.bin/" cmake_src_compile
	if use extras; then
		cmake_build -C "${BUILD_DIR}" doc
		cmake_build doc-full -C "${BUILD_DIR}" doc
	fi
	cmake_build rebuild_cache
}

src_install() {
	if use extras; then
		local HTML_DOCS=( "${BUILD_DIR}/${MY_DN}/doc/generated/html/." )
	fi
	cmake_src_install

	insinto /etc/gvm/sysconfig
	doins "${FILESDIR}/${MY_DN}-daemon.conf"

	insinto /etc/gvm/reverse-proxy
	doins "${FILESDIR}/${MY_PN}.nginx.reverse.proxy.example"
	fowners -R gvm:gvm /etc/gvm

	newinitd "${FILESDIR}/${MY_DN}.init" "${MY_DN}"
	newconfd "${FILESDIR}/${MY_DN}-daemon.conf" "${MY_DN}"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/${MY_DN}.logrotate" "${MY_DN}"

	systemd_dounit "${FILESDIR}/${MY_DN}.service"
}
