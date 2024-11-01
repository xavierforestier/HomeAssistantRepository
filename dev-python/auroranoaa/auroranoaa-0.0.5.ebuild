# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="NOAA Aurora Wrapper for Home Assistant Integration."
HOMEPAGE="https://github.com/djtimca/aurora-api https://pypi.org/project/auroranoaa/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

DOCS="README.md"

RDEPEND="dev-python/aiohttp[${PYTHON_USEDEP}]"
