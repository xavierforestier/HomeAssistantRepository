# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_14 )

inherit distutils-r1 pypi

DESCRIPTION="Pure python 7-zip library"
HOMEPAGE="https://github.com/miurahr/py7zr https://pypi.org/project/py7zr"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	dev-python/texttable[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.20.0[${PYTHON_USEDEP}]
	>=dev-python/brotlicffi-1.2.0.0[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	>=dev-python/pyppmd-1.3.1[${PYTHON_USEDEP}]
	>=dev-python/pybcj-1.0.6[${PYTHON_USEDEP}]
	>=dev-python/multivolumefile-0.2.3[${PYTHON_USEDEP}]
	>=dev-python/inflate64-1.0.4[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
