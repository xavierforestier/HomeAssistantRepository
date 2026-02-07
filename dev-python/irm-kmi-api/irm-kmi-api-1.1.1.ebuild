# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Retrieve data from the Belgian IRM KMI in Python"
HOMEPAGE="https://github.com/jdejaegh/irm-kmi-api https://pypi.org/project/irm-kmi-api/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.13.3[${PYTHON_USEDEP}]
	>=dev-python/svgwrite-1.4.3[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
