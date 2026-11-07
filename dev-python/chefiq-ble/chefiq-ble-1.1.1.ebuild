# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14})

inherit distutils-r1 pypi

DESCRIPTION="Passive BLE advertisement parser for Chef iQ wireless probes (CQ50/CQ60)"
HOMEPAGE="https://github.com/Invader444/chefiq-ble https://pypi.org/project/chefiq-ble"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/bluetooth-data-tools-1.19.0[${PYTHON_USEDEP}]
	>=dev-python/bluetooth-sensor-state-data-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/home-assistant-bluetooth-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/sensor-state-data-2.1.2[${PYTHON_USEDEP}]
"
EPYTEST_PLUGINS=()
distutils_enable_tests pytest
