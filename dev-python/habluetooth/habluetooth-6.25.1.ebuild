# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1 pypi

DESCRIPTION="High availability Bluetooth"
HOMEPAGE="https://github.com/bluetooth-devices/habluetooth https://pypi.org/project/habluetooth/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	>=dev-python/bleak-3.0.2[${PYTHON_USEDEP}]
	>=dev-python/bleak-retry-connector-4.6.1[${PYTHON_USEDEP}]
	>=dev-python/bluetooth-data-tools-1.29.18[${PYTHON_USEDEP}]
	>=dev-python/bluetooth-adapters-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/bluetooth-auto-recovery-1.6.4[${PYTHON_USEDEP}]
	>=dev-python/async-interrupt-1.1.1[${PYTHON_USEDEP}]
	>=dev-python/dbus-fast-5.0.22[${PYTHON_USEDEP}]
	>=dev-python/btsocket-0.3.0[${PYTHON_USEDEP}]
"

BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest-asyncio[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
	)"

distutils_enable_tests pytest
