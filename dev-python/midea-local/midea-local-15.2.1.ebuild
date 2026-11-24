# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Control your Midea M-Smart appliances via local area network"
HOMEPAGE="https://github.com/midea-lan/midea-local https://pypi.org/project/midea-local"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/yarl-1.25.1[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.14.7[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.24.1[${PYTHON_USEDEP}]
	>=dev-python/ifaddr-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/defusedxml-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/colorlog-6.10.1[${PYTHON_USEDEP}]
	>=dev-python/anyio-4.14.2[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.14.5[${PYTHON_USEDEP}]
	>=dev-python/aiofiles-25.1.0[${PYTHON_USEDEP}]
	dev-python/aiofiles[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/anyio[${PYTHON_USEDEP}]
	dev-python/colorlog[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]
	dev-python/ifaddr[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.5.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
