# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="An API to read the status of an intellifire wifi module"
HOMEPAGE="https://github.com/jeeftor/intellifire4py https://pypi.org/project/intellifire4py/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	>=dev-python/aiohttp-3.9.1[${PYTHON_USEDEP}]
	>=dev-python/aenum-3.1.11[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.10.8[${PYTHON_USEDEP}]
	>=dev-python/rich-10.0.0[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
