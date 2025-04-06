# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Unofficial package to access Bring! shopping lists API."
HOMEPAGE="https://github.com/miaucl/python-bring-api https://pypi.org/project/bring-api/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"
RDEPEND="
	>=dev-python/aiohttp-3.11[${PYTHON_USEDEP}]
	>=dev-python/yarl-1.18.3[${PYTHON_USEDEP}]
	>=dev-python/mashumaro-3.13.1[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.10.12[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
