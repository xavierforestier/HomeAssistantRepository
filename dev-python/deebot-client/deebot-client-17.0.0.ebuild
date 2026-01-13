# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=maturin
CRATES="
	adler2@2.0.1
	aho-corasick@1.1.4
	arc-swap@1.7.1
	autocfg@1.5.0
	base64@0.22.1
	bitflags@2.10.0
	bytemuck@1.24.0
	byteorder-lite@0.1.0
	byteorder@1.5.0
	cc@1.2.48
	cfg-if@1.0.4
	crc32fast@1.5.0
	either@1.15.0
	equivalent@1.0.2
	fdeflate@0.3.7
	find-msvc-tools@0.1.5
	flate2@1.1.5
	futures-core@0.3.31
	futures-macro@0.3.31
	futures-task@0.3.31
	futures-timer@3.0.3
	futures-util@0.3.31
	getrandom@0.3.4
	glob@0.3.3
	hashbrown@0.16.1
	heck@0.5.0
	image@0.25.9
	indexmap@2.12.1
	indoc@2.0.7
	itertools@0.14.0
	itoa@1.0.15
	jobserver@0.1.34
	libc@0.2.178
	liblzma-sys@0.4.4
	liblzma@0.4.5
	log@0.4.29
	memchr@2.7.6
	memoffset@0.9.1
	miniz_oxide@0.8.9
	moxcms@0.7.10
	num-traits@0.2.19
	once_cell@1.21.3
	ordermap@1.0.0
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	pkg-config@0.3.32
	png@0.18.0
	portable-atomic@1.11.1
	proc-macro-crate@3.4.0
	proc-macro2@1.0.103
	pxfm@0.1.26
	pyo3-build-config@0.27.2
	pyo3-ffi@0.27.2
	pyo3-log@0.13.2
	pyo3-macros-backend@0.27.2
	pyo3-macros@0.27.2
	pyo3@0.27.2
	quote@1.0.42
	r-efi@5.3.0
	regex-automata@0.4.13
	regex-syntax@0.8.8
	regex@1.12.2
	relative-path@1.9.3
	rstest@0.26.1
	rstest_macros@0.26.1
	rustc_version@0.4.1
	rustversion@1.0.22
	ryu@1.0.20
	semver@1.0.27
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.145
	shlex@1.3.0
	simd-adler32@0.3.7
	slab@0.4.11
	strum@0.27.2
	strum_macros@0.27.2
	svg@0.18.0
	syn@2.0.111
	target-lexicon@0.13.3
	toml_datetime@0.7.3
	toml_edit@0.23.7
	toml_parser@1.0.4
	unicode-ident@1.0.22
	unindent@0.2.4
	wasip2@1.0.1+wasi-0.2.4
	winnow@0.7.14
	wit-bindgen@0.46.0
	zstd-safe@7.2.4
	zstd-sys@2.0.16+zstd.1.5.7
	zstd@0.13.3
"

inherit cargo distutils-r1 pypi

DESCRIPTION="Deebot client library in python 3"
HOMEPAGE="https://github.com/DeebotUniverse/client.py https://pypi.org/project/deebot-client/"
SRC_URI="
	https://github.com/DeebotUniverse/client.py/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	${RUST_DEPEND}
	>=dev-python/aiohttp-3.10[${PYTHON_USEDEP}]
	>=dev-python/aiomqtt-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/cachetools-5.0.0[${PYTHON_USEDEP}]
	>=dev-python/defusedxml-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.11.3[${PYTHON_USEDEP}]
"
BDEPEND="dev-python/pytest-asyncio[${PYTHON_USEDEP}]
	dev-python/pytest-timeout[${PYTHON_USEDEP}]
	>=dev-python/pycountry-24.6.1[${PYTHON_USEDEP}]"
src_unpack() {
	default
	mv "${WORKDIR}/client.py-${PV}" "$S"
	cargo_src_unpack
}
distutils_enable_tests pytest
