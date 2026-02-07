# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python module to talk to Google Air Quality API"
HOMEPAGE="https://github.com/Thomas55555/python-google-air-quality-api https://pypi.org/project/google-air-quality-api/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

PATCHES="${FILESDIR}/${PN}-fix-poetry.patch"

RDEPEND="
	>=dev-python/aiohttp-3.9.3[${PYTHON_USEDEP}]
	>=dev-python/mashumaro-3.12[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
