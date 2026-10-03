# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="Simplepush python library"
HOMEPAGE="https://github.com/simplepush/simplepush-python https://simplepush.io https://pypi.org/project/simplepush/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="legacy test"
RESTRICT="!test? ( test )"

#DOCS="README.rst"

RDEPEND="
	>=dev-python/websockets-12.0[${PYTHON_USEDEP}]
	legacy? (
		>=dev-python/cryptography-3.1[${PYTHON_USEDEP}]
	)
	>=dev-python/pynacl-1.5.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	py.test -v -v || die
}

distutils_enable_tests pytest
