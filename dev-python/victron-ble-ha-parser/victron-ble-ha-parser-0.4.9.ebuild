# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A parser for Victron BLE messages suitable for use with Home Assistant"
HOMEPAGE="https://github.com/rajlaud/victron-ble-ha-parser https://pypi.org/project/victron-ble-ha-parser/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/bluetooth-sensor-state-data-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/sensor-state-data-2.16.0[${PYTHON_USEDEP}]
	>=dev-python/victron-ble-0.9.2[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
