# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
DISTUTILS_USE_PEP517=maturin
DISTUTILS_EXT=1
PYTHON_COMPAT=( python3_{12..14} )
CRATES="
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	either@1.15.0
	heck@0.5.0
	libc@0.2.183
	once_cell@1.21.4
	portable-atomic@1.13.1
	proc-macro2@1.0.106
	pyo3-build-config@0.28.2
	pyo3-ffi@0.28.2
	pyo3-macros-backend@0.28.2
	pyo3-macros@0.28.2
	pyo3@0.28.2
	quote@1.0.45
	rayon-core@1.13.0
	rayon@1.11.0
	syn@2.0.117
	target-lexicon@0.13.5
	unicode-ident@1.0.24
	adler2@2.0.1
	aho-corasick@1.1.4
	aligned-vec@0.6.4
	aligned@0.4.3
	anes@0.1.6
	anstyle@1.0.14
	anyhow@1.0.102
	approx@0.5.1
	arbitrary@1.4.2
	arg_enum_proc_macro@0.3.4
	arrayvec@0.7.6
	as-slice@0.2.1
	autocfg@1.5.1
	av-scenechange@0.14.1
	av1-grain@0.2.5
	avif-serialize@0.8.9
	bit_field@0.10.3
	bitflags@2.13.0
	bitstream-io@4.10.0
	built@0.8.1
	bumpalo@3.20.3
	bytemuck@1.25.0
	byteorder-lite@0.1.0
	cast@0.3.0
	cc@1.2.63
	cfg-if@1.0.4
	ciborium-io@0.2.2
	ciborium-ll@0.2.2
	ciborium@0.2.2
	clap@4.6.1
	clap_builder@4.6.0
	clap_lex@1.1.0
	color_quant@1.1.0
	crc32fast@1.5.0
	criterion-plot@0.5.0
	criterion@0.5.1
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crunchy@0.2.4
	either@1.16.0
	equator-macro@0.4.2
	equator@0.4.2
	exr@1.74.0
	fax@0.2.7
	fdeflate@0.3.7
	find-msvc-tools@0.1.9
	flate2@1.1.9
	futures-core@0.3.32
	futures-task@0.3.32
	futures-util@0.3.32
	getrandom@0.3.4
	gif@0.14.2
	half@2.7.1
	hermit-abi@0.5.2
	image-webp@0.2.4
	image@0.25.10
	imgref@1.12.2
	interpolate_name@0.2.4
	is-terminal@0.4.17
	itertools@0.10.5
	itertools@0.14.0
	itoa@1.0.18
	jobserver@0.1.34
	js-sys@0.3.99
	lebe@0.5.3
	libc@0.2.186
	libfuzzer-sys@0.4.13
	log@0.4.32
	loop9@0.1.5
	maybe-rayon@0.1.1
	memchr@2.8.1
	miniz_oxide@0.8.9
	moxcms@0.8.1
	new_debug_unreachable@1.0.6
	no_std_io2@0.9.4
	nom@8.0.0
	noop_proc_macro@0.3.0
	num-bigint@0.4.6
	num-derive@0.4.2
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	once_cell@1.21.4
	oorandom@11.1.5
	paste@1.0.15
	pastey@0.1.1
	pin-project-lite@0.2.17
	plotters-backend@0.3.7
	plotters-svg@0.3.7
	plotters@0.3.7
	png@0.18.1
	ppv-lite86@0.2.21
	proc-macro2@1.0.106
	profiling-procmacros@1.0.18
	profiling@1.0.18
	pxfm@0.1.29
	qoi@0.4.1
	quick-error@2.0.1
	quote@1.0.45
	r-efi@5.3.0
	rand@0.9.4
	rand_chacha@0.9.0
	rand_core@0.9.5
	rav1e@0.8.1
	ravif@0.13.0
	rayon-core@1.13.0
	rayon@1.12.0
	regex-automata@0.4.14
	regex-syntax@0.8.10
	regex@1.12.3
	rgb@0.8.53
	rustversion@1.0.22
	same-file@1.0.6
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.150
	shlex@2.0.1
	simd-adler32@0.3.9
	simd_helpers@0.1.0
	slab@0.4.12
	smallvec@1.15.1
	stable_deref_trait@1.2.1
	syn@2.0.117
	thiserror-impl@2.0.18
	thiserror@2.0.18
	tiff@0.11.3
	tinytemplate@1.2.1
	unicode-ident@1.0.24
	v_frame@0.3.9
	walkdir@2.5.0
	wasip2@1.0.3+wasi-0.2.9
	wasm-bindgen-macro-support@0.2.122
	wasm-bindgen-macro@0.2.122
	wasm-bindgen-shared@0.2.122
	wasm-bindgen@0.2.122
	web-sys@0.3.99
	weezl@0.1.12
	winapi-util@0.1.11
	windows-link@0.2.1
	windows-sys@0.61.2
	wit-bindgen@0.57.1
	y4m@0.8.0
	zerocopy-derive@0.8.50
	zerocopy@0.8.50
	zmij@1.0.21
	zune-core@0.5.1
	zune-inflate@0.2.54
	zune-jpeg@0.5.15
"
inherit cargo distutils-r1 pypi

DESCRIPTION="Dithering algorithms for e-paper/e-ink displays"
HOMEPAGE="https://github.com/OpenDisplay/epaper-dithering https://pypi.org/project/epaper-dithering"
SRC_URI="
	https://github.com/OpenDisplay/epaper-dithering/archive/refs/tags/${PN}-v${PV}.tar.gz -> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	${RUST_DEPEND}
	>=dev-python/pillow-10.0.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.24.0[${PYTHON_USEDEP}]
"

src_unpack() {
	default
	cd "${WORKDIR}/epaper-dithering-epaper-dithering-v${PV}/packages/rust/" || exit
	cargo_src_unpack
}

src_compile() {
	cd "${WORKDIR}/epaper-dithering-epaper-dithering-v${PV}/packages/rust/core" || exit
	cargo_src_compile
	cd "${WORKDIR}/epaper-dithering-epaper-dithering-v${PV}/packages/python/" || exit
	distutils-r1_src_compile
}

src_install() {
	cd "${WORKDIR}/epaper-dithering-epaper-dithering-v${PV}/packages/python/" || exit
	distutils-r1_src_install
}

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
