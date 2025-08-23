# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Python client for Intex Spa wifi interface"
HOMEPAGE="https://github.com/mathieu-mp/intex-spa https://pypi.org/project/intex-spa/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aio-intex-spa-0.9.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
