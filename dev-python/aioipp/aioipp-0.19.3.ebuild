# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous Python client for Internet Printing Protocol (IPP)"
HOMEPAGE="https://github.com/brianegge/aioipp https://pypi.org/project/aioipp"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	!dev-python/pyipp[${PYTHON_USEDEP}]
	>=dev-python/awesomeversion-21.10.1[${PYTHON_USEDEP}]
	>=dev-python/deepmerge-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/yarl-1.6.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
