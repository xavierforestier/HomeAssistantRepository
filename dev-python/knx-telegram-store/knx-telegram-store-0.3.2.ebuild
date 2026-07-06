# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A standalone, host-agnostic Python library for KNX telegram persistence."
HOMEPAGE="https://github.com/XKNX/knx-telegram-store https://pypi.org/project/knx-telegram-store"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm ar64 x86"
IUSE="sqlite postgres"

RDEPEND="
	sqlite? ( >=dev-python/aiosqlite-0.20[${PYTHON_USEDEP}] >=dev-python/sqlalchemy-2.0[asyncio,${PYTHON_USEDEP}] )
	postgres? ( >=dev-python/asyncpg-0.29[${PYTHON_USEDEP}] >=dev-python/sqlalchemy-2.0[asyncio,${PYTHON_USEDEP}] )
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
