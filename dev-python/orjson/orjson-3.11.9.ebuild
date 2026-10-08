# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{11..14} )

# upstream is vendoring crates
CRATES="
	associative-cache@2.0.0
	bytecount@0.6.9
	bytes@1.11.0
	cc@1.2.55
	cfg-if@1.0.4
	crunchy@0.2.4
	encoding_rs@0.8.35
	find-msvc-tools@0.1.9
	gimli@0.32.3
	half@2.7.1
	itoa@1.0.17
	itoap@1.0.1
	jiff-static@0.2.18
	jiff@0.2.18
	libc@0.2.180
	memchr@2.7.6
	no-panic@0.1.36
	once_cell@1.21.3
	portable-atomic-util@0.2.5
	portable-atomic@1.13.1
	proc-macro2@1.0.106
	pyo3-build-config@0.28.0
	pyo3-ffi@0.28.0
	quote@1.0.44
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.149
	shlex@1.3.0
	simdutf8@0.1.5
	smallvec@1.15.1
	syn@2.0.114
	target-lexicon@0.13.4
	unicode-ident@1.0.22
	unwinding@0.2.8
	uuid@1.20.0
	version_check@0.9.5
	xxhash-rust@0.8.15
	zerocopy-derive@0.8.37
	zerocopy@0.8.37
	zmij@1.0.19
"

RUST_MIN_VER="1.74.1"

inherit cargo distutils-r1 pypi

DESCRIPTION="Fast, correct Python JSON library supporting dataclasses, datetimes, and numpy"
HOMEPAGE="
	https://github.com/ijl/orjson/
	https://pypi.org/project/orjson/
"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+="
	Apache-2.0-with-LLVM-exceptions BSD Boost-1.0 MIT Unicode-3.0
"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~loong ~mips ppc ppc64 ~riscv ~s390 ~sparc ~x86"
BDEPEND="
	>=dev-util/maturin-1.7.8[${PYTHON_USEDEP}]
	test? (
		dev-python/arrow[${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}]
		dev-python/psutil[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
	)
"

QA_FLAGS_IGNORED=".*"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
