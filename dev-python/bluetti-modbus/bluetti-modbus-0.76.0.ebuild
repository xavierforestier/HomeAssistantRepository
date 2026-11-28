# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Unofficial library for basic communication to BLUETTI Power Stations via Modbus"
HOMEPAGE="https://github.com/bluetti-community/bluetti-modbus https://pypi.org/project/bluetti-modbus"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/probatio-0.11.4[${PYTHON_USEDEP}]
	>=dev-python/modbus-connection-4.11.1[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest