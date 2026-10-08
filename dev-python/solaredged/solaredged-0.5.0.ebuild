# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous Python client for SolarEdge inverters over Modbus"
HOMEPAGE="https://github.com/frenck/python-solaredged https://pypi.org/project/solaredged"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="pymodbus tmodbus"

RDEPEND="
	>=dev-python/modbus-connection-4.8.1[${PYTHON_USEDEP}]
	pymodbus? ( dev-python/modbus-connection[${PYTHON_USEDEP},pymodbus] )
	tmodbus? ( dev-python/modbus-connection[${PYTHON_USEDEP},tmodbus] )
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
