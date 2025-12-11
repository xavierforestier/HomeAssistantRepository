# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Aurelio Platform SDK"
HOMEPAGE="https://pypi.org/project/aurelio-sdk/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
PATCHES="${FILESDIR}/${PN}-fix-poetry.patch"
RDEPEND="
	>=dev-python/aiohttp-3.10.11[${PYTHON_USEDEP}]
	>=dev-python/requests-2.32.3[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.9.2[${PYTHON_USEDEP}]
	>=dev-python/colorlog-6.8.2[${PYTHON_USEDEP}]
	>=dev-python/requests-toolbelt-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/aiofiles-24.1.0[${PYTHON_USEDEP}]
	>=dev-python/tornado-6.4.2[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
