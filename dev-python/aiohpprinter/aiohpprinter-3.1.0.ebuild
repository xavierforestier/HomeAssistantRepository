# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python library to get information from HP printers"
HOMEPAGE="https://github.com/chemelli74/aiohpprinter https://pypi.org/project/aiohpprinter"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/defusedxml-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.14.5[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest