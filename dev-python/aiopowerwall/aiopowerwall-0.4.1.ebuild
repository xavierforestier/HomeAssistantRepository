# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Async Tesla Powerwall 3 client over the TEDAPI v1r RSA-signed LAN protocol"
HOMEPAGE="https://github.com/Teslemetry/aiopowerwall https://pypi.org/project/aiopowerwall"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.9[${PYTHON_USEDEP}]
	>=dev-python/cryptography-41[${PYTHON_USEDEP}]
	>=dev-python/protobuf-4.25[${PYTHON_USEDEP}]
	>=dev-python/tesla-protocol-1.4.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
