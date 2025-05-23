# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Module for interacting with Wallbox EV charger api"
HOMEPAGE="https://github.com/cliviu74/wallbox https://pypi.org/project/wallbox/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	>=dev-python/requests-2.32.0[${PYTHON_USEDEP}]
	>=dev-python/aenum-3.1.15[${PYTHON_USEDEP}]
	>=dev-python/certifi-2024.7.4[${PYTHON_USEDEP}]
	>=dev-python/charset-normalizer-3.3.0[${PYTHON_USEDEP}]
	>=dev-python/idna-3.7[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/urllib3-2.2.2[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
