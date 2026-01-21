# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler@1.0.2
	arrayref@0.3.7
	arrayvec@0.7.6
	autocfg@1.2.0
	base64@0.22.1
	bitflags@1.3.2
	bitflags@2.5.0
	bytemuck@1.15.0
	byteorder-lite@0.1.0
	cfg-if@1.0.0
	color_quant@1.1.0
	core_maths@0.1.1
	crc32fast@1.4.0
	data-url@0.3.1
	euclid@0.22.11
	fdeflate@0.3.4
	flate2@1.0.28
	float-cmp@0.9.0
	fontconfig-parser@0.5.6
	fontdb@0.23.0
	gif@0.13.1
	heck@0.5.0
	image-webp@0.2.3
	imagesize@0.13.0
	indoc@2.0.5
	kurbo@0.11.0
	kurbo@0.12.0
	libc@0.2.153
	libm@0.2.15
	log@0.4.29
	memmap2@0.9.4
	memoffset@0.9.1
	miniz_oxide@0.7.2
	num-traits@0.2.19
	once_cell@1.21.3
	pico-args@0.5.0
	png@0.17.13
	portable-atomic@1.6.0
	proc-macro2@1.0.92
	pyo3-build-config@0.27.2
	pyo3-ffi@0.27.2
	pyo3-macros-backend@0.27.2
	pyo3-macros@0.27.2
	pyo3@0.27.2
	quick-error@2.0.1
	quote@1.0.36
	resvg@0.45.1
	rgb@0.8.37
	roxmltree@0.19.0
	roxmltree@0.20.0
	rustybuzz@0.20.1
	simd-adler32@0.3.7
	simplecss@0.2.1
	siphasher@1.0.1
	slotmap@1.0.7
	smallvec@1.15.1
	strict-num@0.1.1
	svgtypes@0.15.3
	svgtypes@0.16.0
	syn@2.0.90
	target-lexicon@0.13.2
	tiny-skia-path@0.11.4
	tiny-skia@0.11.4
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	ttf-parser@0.25.1
	unicode-bidi-mirroring@0.4.0
	unicode-bidi@0.3.15
	unicode-ccc@0.4.0
	unicode-ident@1.0.12
	unicode-properties@0.1.3
	unicode-script@0.5.6
	unicode-vo@0.1.0
	unindent@0.2.3
	usvg@0.45.1
	version_check@0.9.4
	weezl@0.1.8
	xmlwriter@0.1.0
	zune-core@0.4.12
	zune-jpeg@0.4.19
"

DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{12..14} )
CARGO_OPTIONAL=1

inherit cargo distutils-r1 pypi

DESCRIPTION="A safe and high level binding for the resvg project"
HOMEPAGE="https://pypi.org/project/resvg-py/ https://github.com/baseplate-admin/resvg-py"
SRC_URI="$(pypi_sdist_url) ${CARGO_CRATE_URIS}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
RDEPEND="
	${RUST_DEPEND}
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_unpack() {
	default
	cargo_src_unpack
}
