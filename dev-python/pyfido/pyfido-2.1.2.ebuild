# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Get your Fido consumption (wwww.fido.ca)"
HOMEPAGE="https://github.com/titilambert/pyfido https://pypi.org/project/pyfido/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
DOCS="README.rst"
RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]"
