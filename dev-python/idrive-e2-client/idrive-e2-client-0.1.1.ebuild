# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Async Python client for the IDrive e2 Get Region Endpoint API (returns only endpoint URL)".
HOMEPAGE="https://github.com/patrickvorgers/idrive-e2-client https://pypi.org/project/idrive-e2-client/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm ar64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.9[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.9.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
