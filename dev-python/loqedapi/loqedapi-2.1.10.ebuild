# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN="loqedAPI"
inherit distutils-r1 pypi

DESCRIPTION="Use the Loqed Smart Door Lock APIs in a local network"
HOMEPAGE="https://github.com/cpolhout/loqedAPI https://pypi.org/project/loqedAPI/"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/async-timeout[${PYTHON_USEDEP}]' python3_10)"

distutils_enable_tests pytest
