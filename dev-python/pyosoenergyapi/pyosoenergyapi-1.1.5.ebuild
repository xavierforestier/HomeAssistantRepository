# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A Python library to interface with the OSO Energy API"
HOMEPAGE="https://github.com/osohotwateriot/apyosohotwaterapi https://pypi.org/project/pyosoenergyapi/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/loguru[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
