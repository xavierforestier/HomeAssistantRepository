# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A client for OMIE - Spain and Portugal electricity market data"
HOMEPAGE="https://github.com/luuuis/pyomie https://pypi.org/project/pyomie"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/rich-10[${PYTHON_USEDEP}]
	>=dev-python/typer-0.12[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.9.1[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
