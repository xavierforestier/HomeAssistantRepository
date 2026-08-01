# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A small, backend-neutral Modbus connection abstraction (pymodbus / tmodbus)."
HOMEPAGE="https://github.com/home-assistant-libs/modbus-connection https://pypi.org/project/modbus-connection"
IUSE="pymodbus"
LICENSE="Apache2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
RDEPENDS="
	pymodbus? ( >=dev-python/pymodbus-3.11[${PYTHON_USEDEP},serial] )
"
EPYTEST_PLUGINS=()
distutils_enable_tests pytest
