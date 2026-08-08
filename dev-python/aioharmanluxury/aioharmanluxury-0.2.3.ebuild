# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Harman Luxury Audio / StreamUnlimited network streamers"
HOMEPAGE="https://github.com/sbesh91/aioharmanluxury https://pypi.org/project/aioharmanluxury"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.9[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
