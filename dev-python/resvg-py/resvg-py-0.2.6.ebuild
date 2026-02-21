# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2@2.0.1
	arrayref@0.3.9
	arrayvec@0.7.6
	autocfg@1.5.0
	base64@0.22.1
	bitflags@1.3.2
	bitflags@2.10.0
	bytemuck@1.24.0
	byteorder-lite@0.1.0
	cfg-if@1.0.4
	color_quant@1.1.0
	core_maths@0.1.1
	crc32fast@1.5.0
	data-url@0.3.2
	euclid@0.22.11
	fdeflate@0.3.7
	flate2@1.1.5
	float-cmp@0.9.0
	fontconfig-parser@0.5.8
	fontdb@0.23.0
	gif@0.14.1
	heck@0.5.0
	image-webp@0.2.4
	imagesize@0.14.0
	indoc@2.0.7
	kurbo@0.13.0
	libc@0.2.180
	libm@0.2.15
	log@0.4.29
	memchr@2.7.6
	memmap2@0.9.9
	memoffset@0.9.1
	miniz_oxide@0.8.9
	num-traits@0.2.19
	once_cell@1.21.3
	pico-args@0.5.0
	png@0.17.16
	portable-atomic@1.13.0
	proc-macro2@1.0.105
	pyo3-build-config@0.27.2
	pyo3-ffi@0.27.2
	pyo3-macros-backend@0.27.2
	pyo3-macros@0.27.2
	pyo3@0.27.2
	quick-error@2.0.1
	quote@1.0.43
	resvg@0.46.0
	rgb@0.8.52
	roxmltree@0.20.0
	roxmltree@0.21.1
	rustversion@1.0.22
	rustybuzz@0.20.1
	simd-adler32@0.3.8
	simplecss@0.2.2
	siphasher@1.0.1
	slotmap@1.1.1
	smallvec@1.15.1
	strict-num@0.1.1
	svgtypes@0.16.1
	syn@2.0.114
	target-lexicon@0.13.4
	tiny-skia-path@0.11.4
	tiny-skia@0.11.4
	tinyvec@1.10.0
	tinyvec_macros@0.1.1
	ttf-parser@0.25.1
	unicode-bidi-mirroring@0.4.0
	unicode-bidi@0.3.18
	unicode-ccc@0.4.0
	unicode-ident@1.0.22
	unicode-properties@0.1.4
	unicode-script@0.5.8
	unicode-vo@0.1.0
	unindent@0.2.4
	usvg@0.46.0
	version_check@0.9.5
	weezl@0.1.12
	xmlwriter@0.1.0
	zune-core@0.5.0
	zune-jpeg@0.5.8
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
