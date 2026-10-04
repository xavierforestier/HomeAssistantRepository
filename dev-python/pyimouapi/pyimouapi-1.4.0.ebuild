# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A package for imou open api"
HOMEPAGE="https://github.com/Imou-OpenPlatform/Py-Imou-Open-Api https://pypi.org/project/pyimouapi"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.11.9[${PYTHON_USEDEP}]
	>=dev-python/simpleeval-1.0.3[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
