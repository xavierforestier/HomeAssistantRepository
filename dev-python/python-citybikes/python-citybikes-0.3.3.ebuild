# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Client interface for the Citybikes API"
HOMEPAGE="https://github.com/eskerda/python-citybikes https://pypi.org/project/python-citybikes/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

PATCHES="${FILESDIR}/${PN}-build-system.patch"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
