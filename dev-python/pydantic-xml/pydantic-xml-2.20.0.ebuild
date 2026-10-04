# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="pydantic xml extension"
HOMEPAGE="https://github.com/dapper91/pydantic-xml https://pypi.org/project/pydantic-xml"

LICENSE="unlicenced"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/lxml-4.9.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.6.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
