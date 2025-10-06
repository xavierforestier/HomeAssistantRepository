# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="An extension to click that easily turns your click app into a shell utility"
HOMEPAGE="https://github.com/clarkperkins/click-shell https://pypi.org/project/click-shell/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND=">=dev-python/click-7.0[${PYTHON_USEDEP}]"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
