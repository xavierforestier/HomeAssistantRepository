# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous Python wrapper for the local Google Wifi JSON API"
HOMEPAGE="https://github.com/EReaso/GoogleWifiApi https://pypi.org/project/googlewifiapi"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/yarl-1.24.5[${PYTHON_USEDEP}]
	>=dev-python/mashumaro-3.22[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.11.0[${PYTHON_USEDEP}]
	>=dev-python/typing_extensions-4.14.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
