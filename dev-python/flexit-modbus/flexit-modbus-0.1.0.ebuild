# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Read and control a Flexit air handling unit with a CI66 Modbus adapter."
HOMEPAGE="https://github.com/troelde/flexit-modbus https://pypi.org/project/flexit-modbus"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/modbus-connection-4.10.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
