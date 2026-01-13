# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
CARGO_OPTIONAL=1
DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=( python3_{12..14} )
CRATES="
	ahash@0.8.12
	arbitrary@1.4.1
	autocfg@1.4.0
	bencher@0.1.5
	bitflags@2.9.1
	bitvec@1.0.1
	cc@1.2.23
	cfg-if@1.0.0
	codspeed-bencher-compat@2.10.1
	codspeed@2.10.1
	colored@2.2.0
	equivalent@1.0.2
	funty@2.0.0
	getrandom@0.3.3
	hashbrown@0.15.3
	heck@0.5.0
	indexmap@2.9.0
	indoc@2.0.6
	itoa@1.0.15
	jobserver@0.1.33
	lazy_static@1.5.0
	lexical-parse-float@1.0.5
	lexical-parse-integer@1.0.5
	lexical-util@1.0.6
	libc@0.2.172
	libfuzzer-sys@0.4.9
	memchr@2.7.4
	memoffset@0.9.1
	num-bigint@0.4.6
	num-integer@0.1.46
	num-traits@0.2.19
	once_cell@1.21.3
	paste@1.0.15
	portable-atomic@1.11.0
	proc-macro2@1.0.95
	pyo3-build-config@0.25.0
	pyo3-ffi@0.25.0
	pyo3-macros-backend@0.25.0
	pyo3-macros@0.25.0
	pyo3@0.25.0
	python3-dll-a@0.2.14
	quote@1.0.40
	r-efi@5.2.0
	radium@0.7.0
	ryu@1.0.20
	serde@1.0.219
	serde_derive@1.0.219
	serde_json@1.0.140
	shlex@1.3.0
	smallvec@1.15.0
	static_assertions@1.1.0
	syn@2.0.101
	tap@1.0.1
	target-lexicon@0.13.2
	unicode-ident@1.0.18
	unindent@0.2.4
	uuid@1.16.0
	version_check@0.9.5
	wasi@0.14.2+wasi-0.2.4
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	wit-bindgen-rt@0.39.0
	wyz@0.5.1
	zerocopy-derive@0.8.25
	zerocopy@0.8.25
"
inherit cargo distutils-r1 pypi

DESCRIPTION="Fast iterable JSON parser"
HOMEPAGE="https://pypi.org/project/jiter/ https://github.com/pydantic/jiter/"
SRC_URI="
	$(pypi_sdist_url "${PN^}" "${PV}")
	${CARGO_CRATE_URIS}
"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="${RUST_DEPEND}"

src_unpack() {
	cargo_src_unpack
}
distutils_enable_tests pytest
