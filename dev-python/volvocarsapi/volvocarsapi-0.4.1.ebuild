# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python client for the Volvo Cars API"
HOMEPAGE="https://github.com/thomasddn/volvo-cars-api https://pypi.org/project/volvocarsapi/"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.12.14[${PYTHON_USEDEP}]
	>=dev-python/yarl-1.20.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
