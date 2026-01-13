# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Api wrapper for Melissa Climate https://seemelissa.com"
HOMEPAGE="https://github.com/kennedyshead/py-melissa-climate https://pypi.org/project/py-melissa-climate/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]"
BDEPEND="
	dev-python/setuptools-markdown[${PYTHON_USEDEP}]
	dev-python/pypandoc[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"
distutils_enable_tests unittest
