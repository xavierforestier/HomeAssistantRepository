# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="An async Python wrapper for the Chess.com API"
HOMEPAGE="https://github.com/Stupidoodle/chess-com-api https://pypi.org/project/chess-com-api/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arml arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.8.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
