# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=maturin
CRATES="
	adler2@2.0.1
	aho-corasick@1.1.5
	arc-swap@1.9.2
	autocfg@1.5.1
	base64@0.23.1
	bitflags@2.13.2
	bytemuck@1.25.2
	byteorder-lite@0.1.0
	byteorder@1.5.0
	cc@1.4.5
	cfg-if@1.0.4
	crc32fast@1.5.1
	either@1.18.0
	equivalent@1.0.2
	fdeflate@0.3.7
	find-msvc-tools@0.1.12
	flate2@1.1.10
	futures-core@0.3.34
	futures-task@0.3.34
	futures-timer@3.0.4
	futures-util@0.3.34
	getrandom@0.4.3
	glob@0.3.4
	hashbrown@0.17.1
	heck@0.5.0
	image@0.25.10
	indexmap@2.14.2
	itertools@0.15.0
	itoa@1.0.18
	jobserver@0.1.35
	libc@0.2.189
	liblzma-sys@0.4.8
	liblzma@0.4.8
	log@0.4.34
	memchr@2.8.3
	miniz_oxide@0.8.9
	miniz_oxide@0.9.1
	moxcms@0.8.1
	num-traits@0.2.19
	once_cell@1.21.4
	ordermap@1.2.2
	pin-project-lite@0.2.17
	pkg-config@0.3.34
	png@0.18.1
	portable-atomic@1.15.0
	proc-macro-crate@3.5.0
	proc-macro2@1.0.107
	pxfm@0.1.30
	pyo3-build-config@0.29.2
	pyo3-ffi@0.29.2
	pyo3-log@0.13.4
	pyo3-macros-backend@0.29.2
	pyo3-macros@0.29.2
	pyo3@0.29.2
	quote@1.0.47
	r-efi@6.0.0
	regex-automata@0.4.18
	regex-syntax@0.8.11
	regex@1.13.1
	relative-path@1.9.3
	rstest@0.27.0
	rstest_macros@0.27.0
	rustc_version@0.4.1
	rustversion@1.0.23
	semver@1.0.28
	serde@1.0.229
	serde_core@1.0.229
	serde_derive@1.0.229
	serde_json@1.0.151
	shlex@2.0.1
	simd-adler32@0.3.10
	strum@0.28.0
	strum_macros@0.28.0
	svg@0.18.0
	syn@2.0.119
	syn@3.0.5
	target-lexicon@0.13.5
	toml_datetime@1.1.1+spec-1.1.0
	toml_edit@0.25.13+spec-1.1.0
	toml_parser@1.1.3+spec-1.1.0
	unicode-ident@1.0.24
	winnow@1.0.4
	zlib-rs@0.6.7
	zmij@1.0.23
	zstd-safe@8.0.0
	zstd-sys@2.1.0+zstd.1.5.7
	zstd@0.14.0
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
	>=dev-python/aiohttp-3.13.3[${PYTHON_USEDEP}]
	>=dev-python/aiomqtt-2.5.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-48.0.1[${PYTHON_USEDEP}]
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
