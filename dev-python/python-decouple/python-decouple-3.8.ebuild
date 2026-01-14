# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Strict separation of settings from code."
HOMEPAGE="https://github.com/HBNetwork/python-decouple https://pypi.org/project/python-decouple/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/mock-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-3.2.0[${PYTHON_USEDEP}]
	>=dev-python/tox-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.14[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.7.4[${PYTHON_USEDEP}]
	dev-python/twine[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
