# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Monarch Money API for Python"
HOMEPAGE="https://github.com/bradleyseanf/monarchmoneycommunity	https://pypi.org/project/monarchmoneycommunity/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	!dev-python/monarchmoney[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.8.4[${PYTHON_USEDEP}]
	>=dev-python/gql-3.5[${PYTHON_USEDEP}]
	>=dev-python/oathtool-2.3.1[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
