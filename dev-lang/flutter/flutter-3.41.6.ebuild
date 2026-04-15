# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=8

inherit bash-completion-r1 readme.gentoo-r1

DESCRIPTION="A client-optimized langauge for fast apps on any platform"
HOMEPAGE="https://flutter.dev/"

SRC_URI="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${PV}-stable.tar.xz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

DEPEND="
	acct-group/flutter
	acct-user/flutter
	=dev-lang/dart-3.11.4[clang]
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	default

	# remove Windows batch files
	find . -iname '*.bat' -delete || die
}

src_compile() {
	# - this needs to be done before snapshotting to avoid sdk mismatch error
	# - this includes the analytics notice, so show it in the elog
	einfo "Building completions"
	DOC_CONTENTS=$("bin/${PN}" bash-completion "${PN}.bash-completion") || die
	DISABLE_AUTOFORMATTING=1 readme.gentoo_create_doc
}

src_install() {
	use examples || rm -r examples/ || die

	# unbundle dart-sdk
	ln -s /usr/lib/dart bin/cache/dart-sdk || die

	newbashcomp "${PN}.bash-completion" "${PN}"
	rm "${PN}.bash-completion"

	chown -R flutter:flutter .

	mkdir "${D}/opt/" || die
	mv "${S}" "${D}/opt/${PN}" || die
	mv "${D}/opt/${PN}/bin/flutter" "${D}/opt/${PN}/bin/flutter.orig"
	echo -e "#!/bin/bash\nsu - flutter -s /bin/bash --session-command=\"/opt/flutter/bin/flutter.orig  \$*\"" > "${D}/opt/${PN}/bin/${PN}"
	chmod +x "${D}/opt/${PN}/bin/${PN}"

	dosym "../opt/${PN}/bin/${PN}" "/sbin/${PN}"

}

pkg_postinst() {
	readme.gentoo_print_elog
}
