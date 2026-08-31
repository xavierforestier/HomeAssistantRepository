# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A package to interact with Anglian Water"
HOMEPAGE="https://github.com/pantherale0/pyanglianwater https://pypi.org/project/pyanglianwater/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	dev-python/pyjwt[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
