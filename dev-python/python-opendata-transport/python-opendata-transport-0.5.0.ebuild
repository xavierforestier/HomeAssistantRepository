# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Python API for interacting with transport.opendata.ch."
HOMEPAGE="https://github.com/home-assistant-ecosystem/python-opendata-transport https://pypi.org/project/python-opendata-transport/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.rst"

RDEPEND=">=dev-python/aiohttp-3.8.5[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
