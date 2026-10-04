# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="ISEO Argo BLE Lock protocol library"
HOMEPAGE="https://github.com/FezVrasta/iseo-argo-ble https://pypi.org/project/iseo-argo-ble"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/bleak-0.21.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-41.0.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
