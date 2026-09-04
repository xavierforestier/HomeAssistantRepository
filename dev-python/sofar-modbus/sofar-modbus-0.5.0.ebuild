# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Read Sofar Solar inverters (HYD, KTL-X and the older PV/storage range) over Modbus."
HOMEPAGE="https://github.com/darkrain-nl/sofar-modbus https://pypi.org/project/sofar-modbus"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/modbus-connection-4.7.0[${PYTHON_USEDEP},tmodbus]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
