# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=maturin
CARGO_OPTIONAL=1
PYTHON_COMPAT=( python3_{12..14} )
CRATES="
	ahash@0.8.12
	autocfg@1.4.0
	bytecount@0.6.9
	byteorder@1.5.0
	cfg-if@1.0.0
	chrono@0.4.42
	crunchy@0.2.3
	half@2.6.0
	itoa@1.0.15
	libc@0.2.171
	memoffset@0.9.1
	num-traits@0.2.19
	once_cell@1.21.3
	portable-atomic@1.11.0
	proc-macro2@1.0.94
	pyo3-build-config@0.27.2
	pyo3-ffi@0.27.2
	pyo3@0.27.2
	quote@1.0.40
	serde@1.0.228
	serde_bytes@0.11.19
	serde_core@1.0.228
	serde_derive@1.0.228
	simdutf8@0.1.5
	smallvec@1.15.1
	syn@2.0.100
	target-lexicon@0.13.2
	unicode-ident@1.0.18
	version_check@0.9.5
	zerocopy-derive@0.8.25
	zerocopy@0.8.25
"

inherit cargo distutils-r1 pypi

DESCRIPTION="Python msgpack library supporting dataclasses, datetimes, and numpy"
HOMEPAGE="https://github.com/ormsgpack/ormsgpack https://pypi.org/project/ormsgpack/"
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

