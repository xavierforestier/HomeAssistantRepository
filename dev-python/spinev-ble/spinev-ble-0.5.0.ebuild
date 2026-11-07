# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="local bluetooth le control for exicom spin ev chargers"
HOMEPAGE="https://github.com/Dr-Blank/spinev-ble https://pypi.org/project/spinev-ble"
IUSE="bleak"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	bleak? (
		>=dev-python/bleak-0.22.0[${PYTHON_USEDEP}]
		>=dev-python/bleak-retry-connector-4.0.0[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
