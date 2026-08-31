# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A modern, strongly typed Modbus client library."
HOMEPAGE="https://github.com/wlcrs/tmodbus https://pypi.org/project/tmodbus"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/tenacity-8.2.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
