# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Unofficial package to access Cookidoo."
HOMEPAGE="https://pypi.org/project/cookidoo-api/ https://github.com/miaucl/cookidoo-api"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.12[${PYTHON_USEDEP}]
	>=dev-python/aiofiles-24.1.0[${PYTHON_USEDEP}]
	>=dev-python/isodate-0.7.2[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
