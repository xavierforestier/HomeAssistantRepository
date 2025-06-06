# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python library to retrieve observations and forecasts from NWS/NOAA"
HOMEPAGE="https://github.com/MatthewFlamm/pynws https://pypi.org/project/pynws/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="retry test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/python-metar[${PYTHON_USEDEP}]
	retry? ( dev-python/tenacity[${PYTHON_USEDEP}] )
"

distutils_enable_tests pytest
