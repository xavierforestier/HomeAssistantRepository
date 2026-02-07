# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Interfaces the opentherm gateway through serial or network connection."
HOMEPAGE="https://github.com/mvn23/pyotgw https://pypi.org/project/pyotgw/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="dev-python/pyserial-asyncio-fast[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
