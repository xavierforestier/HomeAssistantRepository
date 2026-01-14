# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	autocfg@1.5.0
	bitflags@1.3.2
	bitflags@2.10.0
	cfg-if@1.0.4
	core-foundation-sys@0.8.7
	core-foundation@0.10.0
	heck@0.5.0
	indoc@2.0.7
	io-kit-sys@0.4.1
	libc@0.2.178
	libudev-sys@0.1.4
	libudev@0.3.0
	mach2@0.4.3
	memoffset@0.9.1
	nix@0.26.4
	once_cell@1.21.3
	pkg-config@0.3.32
	portable-atomic@1.11.1
	proc-macro2@1.0.103
	pyo3-build-config@0.23.5
	pyo3-ffi@0.23.5
	pyo3-macros-backend@0.23.5
	pyo3-macros@0.23.5
	pyo3@0.23.5
	quote@1.0.40
	rustversion@1.0.22
	scopeguard@1.2.0
	serialport@4.8.1
	syn@2.0.111
	target-lexicon@0.12.16
	thiserror-impl@2.0.17
	thiserror@2.0.17
	unescaper@0.1.8
	unicode-ident@1.0.22
	unindent@0.2.4
	windows-sys@0.52.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
"

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi cargo

DESCRIPTION="Serial library with native async support for Windows and POSIX"
HOMEPAGE="https://github.com/puddly/serialx https://pypi.org/project/serialx/"
SRC_URI="$(pypi_sdist_url) ${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="dev-python/typing-extensions[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

src_install() {
	dolib.so target/release/lib_serialx_rust.so
	distutils-r1_python_install_all
}
