# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12..14} )
inherit cmake distutils-r1 dot-a

DESCRIPTION="Text tokenizer for Neural Network-based text generation"
HOMEPAGE="https://github.com/google/sentencepiece"
SRC_URI="https://github.com/google/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	>=dev-cpp/abseil-cpp-20260107.1
	dev-libs/protobuf:=
	dev-util/google-perftools
	!sci-ml/pysentencepiece
"
DEPEND="${RDEPEND}
	dev-libs/darts
"

DOCS=(
	README.md
	doc/normalization.md
	doc/options.md
	doc/special_symbols.md
)

src_prepare() {
	eapply "${FILESDIR}/${PN}-force-absl-std-ordering.patch"
	cmake_src_prepare
	sed \
		-e 's|@libprotobuf_lite@|protobuf-lite|' \
		-e "s|@includedir_for_pc_file@|${S}/src|" \
		-e "s|@libdir_for_pc_file@|${BUILD_DIR}/src|" \
		"${PN}.pc.in" \
		> "python/${PN}.pc" \
		|| die
	cd python || die
	distutils-r1_src_prepare
}

src_configure() {
	lto-guarantee-fat
	local mycmakeargs=(
		-DSPM_ABSL_PROVIDER=package
		-DSPM_PROTOBUF_PROVIDER=package
	)
	cmake_src_configure
	cd python || die
	LD_LIBRARY_PATH=${BUILD_DIR}/src distutils-r1_src_configure
}

src_compile() {
	cmake_src_compile
	cd python || exit
	distutils-r1_src_compile
}

src_test() {
	LD_LIBRARY_PATH=${BUILD_DIR}/src distutils-r1_src_test
}

python_test() {
	cd python || exit
	${EPYTHON} test/sentencepiece_test.py || die
}

src_install() {
	cmake_src_install
	distutils-r1_src_install
	strip-lto-bytecode
}
