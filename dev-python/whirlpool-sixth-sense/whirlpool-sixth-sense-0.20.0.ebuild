# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Unofficial API for Whirlpool's 6th Sense appliances"
HOMEPAGE="https://github.com/abmantis/whirlpool-sixth-sense/ https://pypi.org/project/whirlpool-sixth-sense/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	>=dev-python/aioconsole-0.3.1[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.11.12[${PYTHON_USEDEP}]
	>=dev-python/websockets-8.1[${PYTHON_USEDEP}]
	>=dev-python/async-timeout-4.0.3[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
