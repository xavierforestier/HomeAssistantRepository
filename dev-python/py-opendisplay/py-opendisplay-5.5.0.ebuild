# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python library for OpenDisplay BLE e-paper displays"
HOMEPAGE="https://github.com/OpenDisplay/py-opendisplay https://pypi.org/project/py-opendisplay"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/bleak-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/pillow-10.0.0[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.24.0[${PYTHON_USEDEP}]
	>=dev-python/bleak-retry-connector-3.5.0[${PYTHON_USEDEP}]
	>=dev-python/epaper-dithering-0.6.3[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
