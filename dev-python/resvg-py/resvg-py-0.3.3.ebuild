# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adler2@2.0.1
	arrayref@0.3.9
	arrayvec@0.7.6
	autocfg@1.5.1
	base64@0.22.1
	bitflags@2.13.0
	bytemuck@1.25.0
	byteorder-lite@0.1.0
	cfg-if@1.0.4
	color_quant@1.1.0
	core_maths@0.1.1
	crc32fast@1.5.0
	data-url@0.3.2
	euclid@0.22.14
	fdeflate@0.3.7
	flate2@1.1.9
	float-cmp@0.9.0
	fontconfig-parser@0.5.8
	fontdb@0.23.0
	gif@0.14.2
	heck@0.5.0
	image-webp@0.2.4
	imagesize@0.14.0
	kurbo@0.13.1
	libc@0.2.186
	libm@0.2.16
	log@0.4.32
	memchr@2.8.2
	memmap2@0.9.10
	miniz_oxide@0.8.9
	num-traits@0.2.19
	once_cell@1.21.4
	pico-args@0.5.0
	png@0.18.1
	polycool@0.4.0
	portable-atomic@1.13.1
	proc-macro2@1.0.106
	pyo3-build-config@0.29.0
	pyo3-ffi@0.29.0
	pyo3-macros-backend@0.29.0
	pyo3-macros@0.29.0
	pyo3@0.29.0
	quick-error@2.0.1
	quote@1.0.45
	resvg@0.47.0
	rgb@0.8.53
	roxmltree@0.20.0
	roxmltree@0.21.1
	rustybuzz@0.20.1
	simd-adler32@0.3.9
	simplecss@0.2.2
	siphasher@1.0.3
	slotmap@1.1.1
	smallvec@1.15.2
	strict-num@0.1.1
	svgtypes@0.16.1
	syn@2.0.117
	target-lexicon@0.13.5
	tiny-skia-path@0.12.0
	tiny-skia@0.12.0
	tinyvec@1.11.0
	tinyvec_macros@0.1.1
	ttf-parser@0.25.1
	unicode-bidi-mirroring@0.4.0
	unicode-bidi@0.3.18
	unicode-ccc@0.4.0
	unicode-ident@1.0.24
	unicode-properties@0.1.4
	unicode-script@0.5.8
	unicode-vo@0.1.0
	usvg@0.47.0
	version_check@0.9.5
	weezl@0.1.12
	xmlwriter@0.1.0
	zune-core@0.5.1
	zune-jpeg@0.5.15
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
