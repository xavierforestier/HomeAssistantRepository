# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python Route B Library for Low-voltage Smart Electric Energy Meters"
HOMEPAGE="https://github.com/nbtk/momonga https://pypi.org/project/momonga/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/pyserial-3.5[${PYTHON_USEDEP}]
"
PYTEST_PLUGINS=()
distutils_enable_tests pytest
