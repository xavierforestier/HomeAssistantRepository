# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Async Python client library for OPNsense"
HOMEPAGE="https://github.com/Snuffy2/aiopnsense https://pypi.org/project/aiopnsense"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.12.0[${PYTHON_USEDEP}]
	>=dev-python/awesomeversion-25.8.0[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.9.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
