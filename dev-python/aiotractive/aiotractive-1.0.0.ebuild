# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi
DESCRIPTION="Asynchronous Python client for the Tractive REST API"
HOMEPAGE="https://github.com/zhulik/aiotractive https://pypi.org/project/aiotractive/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	>=dev-python/aiohttp-3.13.0[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.10.8[${PYTHON_USEDEP}]
	>=dev-python/yarl-1.21.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
