# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="An unofficial Dynalite DyNET interface creating devices."
HOMEPAGE="https://github.com/ziv1234/python-dynalite-devices https://pypi.org/project/dynalite-devices/"

LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	py.test -v -v || die
}

distutils_enable_tests pytest
