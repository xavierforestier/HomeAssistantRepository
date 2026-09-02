# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Async Python client for the UniFi Access local API with WebSocket event support"
HOMEPAGE="https://github.com/imhotep/py-unifi-access https://pypi.org/project/py-unifi-access"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.9.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.0.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
