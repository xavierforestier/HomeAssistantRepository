# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=uv-build
inherit distutils-r1 pypi

DESCRIPTION="Asynchronous Python client for getting forecast solar information"
HOMEPAGE="https://github.com/klaasnicolaas/forecast_solar https://pypi.org/project/forecast-solar/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	>=dev-python/aiohttp-3.14.5[${PYTHON_USEDEP}]
	>=dev-python/yarl-1.25.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
