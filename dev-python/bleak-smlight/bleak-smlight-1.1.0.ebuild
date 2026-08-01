# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Bleak backend for SMLIGHT SLZB Bluetooth proxies"
HOMEPAGE="https://github.com/bluetooth-devices/bleak-smlight https://pypi.org/project/bleak-smlight"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/bluetooth-data-tools-1.18.0[${PYTHON_USEDEP}]
	>=dev-python/habluetooth-6.4.0[${PYTHON_USEDEP}]
	>=dev-python/pysmlight-0.5.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
