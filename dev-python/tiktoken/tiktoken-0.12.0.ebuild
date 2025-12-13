# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CARGO_OPTIONAL=1
CRATES="
	aho-corasick@1.1.4
	autocfg@1.5.0
	bit-set@0.5.3
	bit-vec@0.6.3
	bstr@1.12.1
	fancy-regex@0.13.0
	heck@0.5.0
	indoc@2.0.7
	libc@0.2.178
	memchr@2.7.6
	memoffset@0.9.1
	once_cell@1.21.3
	portable-atomic@1.11.1
	proc-macro2@1.0.103
	pyo3-build-config@0.26.0
	pyo3-ffi@0.26.0
	pyo3-macros-backend@0.26.0
	pyo3-macros@0.26.0
	pyo3@0.26.0
	quote@1.0.42
	regex-automata@0.4.13
	regex-syntax@0.8.8
	regex@1.12.2
	rustc-hash@2.1.1
	rustversion@1.0.22
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	syn@2.0.111
	target-lexicon@0.13.3
	unicode-ident@1.0.22
	unindent@0.2.4
"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi cargo

DESCRIPTION="tiktoken is a fast BPE tokeniser for use with OpenAI's models"
HOMEPAGE="https://github.com/openai/tiktoken https://pypi.org/project/tiktoken/"
SRC_URI="$(pypi_sdist_url "${PN^}") ${CARGO_CRATE_URIS}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
BDEPENDS="
	dev-python/gpep517[${PYTHON_USEDEPS}]
	dev-python/installer[${PYTHON_USEDEPS}]
	dev-python/setuptools[${PYTHON_USEDEPS}]
	dev-python/setuptools-rust[${PYTHON_USEDEPS}]
	dev-python/setuptools-scm[${PYTHON_USEDEPS}]
	dev-python/wheel[${PYTHON_USEDEPS}]
"
RDEPENDS="
	>=dev-python/regex-2022.1.18[${PYTHON_USEDEPS}]
	>=dev-python/requests-2.26.0[${PYTHON_USEDEPS}]
"
EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_unpack() {
	cargo_src_unpack
}

src_install() {
	dolib.so target/release/libtiktoken.so
	distutils-r1_src_install
}
