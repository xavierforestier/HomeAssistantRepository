# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Async Typed Python package for the Chemelex (nVent) RAYCHEM SENZ RestAPI"
HOMEPAGE="https://github.com/nordicopen/pysenz https://pypi.org/project/pysenz/"

LICENSE="LGPLv3+"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	dev-python/httpx[${PYTHON_USEDEP}]
	dev-python/authlib[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
