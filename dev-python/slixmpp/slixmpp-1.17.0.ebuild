# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

RUST_MIN_VER="1.83"
CRATES="
	displaydoc@0.2.7
	heck@0.5.0
	icu_collections@2.3.0
	icu_locale_core@2.3.0
	icu_normalizer@2.3.0
	icu_normalizer_data@2.3.0
	icu_properties@2.3.0
	icu_properties_data@2.3.0
	icu_provider@2.3.1
	idna@1.1.0
	idna_adapter@1.2.2
	jid@0.12.3
	libc@0.2.189
	litemap@0.8.3
	memchr@2.8.3
	once_cell@1.21.4
	portable-atomic@1.15.0
	potential_utf@0.1.6
	proc-macro2@1.0.107
	pyo3-build-config@0.29.2
	pyo3-ffi@0.29.2
	pyo3-macros-backend@0.29.2
	pyo3-macros@0.29.2
	pyo3@0.29.2
	quote@1.0.47
	smallvec@1.16.0
	stable_deref_trait@1.2.1
	stringprep@0.1.5
	syn@2.0.119
	syn@3.0.4
	synstructure@0.13.2
	target-lexicon@0.13.5
	tinystr@0.8.4
	tinyvec@1.12.0
	tinyvec_macros@0.1.1
	unicode-bidi@0.3.18
	unicode-ident@1.0.24
	unicode-normalization@0.1.25
	unicode-properties@0.1.4
	utf8_iter@1.0.4
	writeable@0.6.4
	yoke-derive@0.8.2
	yoke@0.8.3
	zerofrom-derive@0.1.7
	zerofrom@0.1.8
	zerotrie@0.2.5
	zerovec-derive@0.11.6
	zerovec@0.11.8
"

inherit cargo distutils-r1 pypi

DESCRIPTION="Python 3 library for XMPP"
HOMEPAGE="
	https://codeberg.org/poezio/slixmpp/
	https://pypi.org/project/slixmpp/
"
SRC_URI+="
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0-with-LLVM-exceptions MIT MPL-2.0 Unicode-3.0"
SLOT="0"
KEYWORDS="amd64 ~riscv"

RDEPEND="
	>=dev-python/aiodns-3.2.0[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/emoji[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-modules-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.6.1[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-rust[${PYTHON_USEDEP}]
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
"

# Rust
QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/slixmpp/jid.*.so"

distutils_enable_tests unittest

python_test() {
	rm -rf slixmpp || die
	eunittest -s tests
}
