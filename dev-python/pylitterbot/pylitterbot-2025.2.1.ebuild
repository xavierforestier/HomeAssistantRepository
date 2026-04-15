# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="Python package for controlling Whisker automatic robots."
HOMEPAGE="https://github.com/natekspencer/pylitterbot https://pypi.org/project/pylitterbot/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	>=dev-python/aiohttp-3.8.1[${PYTHON_USEDEP}]
	>=dev-python/deepdiff-6.2.1[${PYTHON_USEDEP}] <dev-python/deepdiff-9.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/pycognito-2024.2.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/aioresponses[${PYTHON_USEDEP}]
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/pytest-freezegun[${PYTHON_USEDEP}]
		dev-python/pytest-timeout[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest
