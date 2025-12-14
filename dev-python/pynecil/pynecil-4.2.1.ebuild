# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="Python library to communicate with Pinecil V2 soldering irons via Bluetooth"
HOMEPAGE="https://github.com/tr4nt0r/pynecil/ https://pypi.org/project/pynecil/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

OCS="README.md"
RDEPEND="
	>=dev-python/aiohttp-3.13.2[${PYTHON_USEDEP}]
	>=dev-python/bleak-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/bleak-retry-connector-4.4.3[${PYTHON_USEDEP}]
	>=dev-python/mypy-1.18.2[${PYTHON_USEDEP}]
	>=dev-python/ruff-0.14.4[${PYTHON_USEDEP}]
	>=dev-python/pytest-8.4.2[${PYTHON_USEDEP}]
	>=dev-python/pytest-cov-7.0.0[${PYTHON_USEDEP}]
	>=dev-python/mkdocmaterial-9.6.23[${PYTHON_USEDEP}]
	>=dev-python/mkdocstrings-0.30.1[python,${PYTHON_USEDEP}]
	>=dev-python/pytest-asyncio-1.2.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
