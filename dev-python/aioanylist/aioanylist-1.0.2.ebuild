# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Async-first pure-Python client for AnyList, reconstructed from the official web application"
HOMEPAGE="https://github.com/BookCatKid/aioanylist https://pypi.org/project/aioanylist"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/protobuf-5.27[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.10[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest