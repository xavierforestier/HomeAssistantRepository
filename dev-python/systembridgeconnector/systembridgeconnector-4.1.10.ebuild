# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="System Bridge Connector"
HOMEPAGE="https://github.com/timmo001/system-bridge https://pypi.org/project/systembridgeconnector/"
PATCHES="${FILESDIR}/${P}-requirement.patch"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/systembridgebackend-4.2.5[${PYTHON_USEDEP}]
	>=dev-python/systembridgecli-4.0.5[${PYTHON_USEDEP}]
	>=dev-python/systembridgefrontend-4.0.3[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
