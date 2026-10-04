# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python interface with rejseplanens API 2.0 based on HAFAS"
HOMEPAGE="https://github.com/Jawar19/pyRejseplan https://pypi.org/project/pyrejseplan"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/requests-2.32.4[${PYTHON_USEDEP}]
	>=dev-python/urllib3-2.2.3[${PYTHON_USEDEP}]
	>=dev-python/pydantic-xml-2.20.0[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.10.11[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
