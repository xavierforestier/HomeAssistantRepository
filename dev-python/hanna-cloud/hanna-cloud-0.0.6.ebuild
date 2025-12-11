# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A Python client for the HannaCloud API"
HOMEPAGE="https://github.com/bestycame/hanna_cloud https://pypi.org/project/hanna-cloud/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/requests-2.25.0[${PYTHON_USEDEP}]
	>=dev-python/pycryptodome-3.19.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
