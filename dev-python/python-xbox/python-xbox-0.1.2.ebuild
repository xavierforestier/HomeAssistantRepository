# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A library to authenticate with Xbox Network and use their API"
HOMEPAGE="https://github.com/tr4nt0r/python-xbox https://pypi.org/project/python-xbox/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	!dev-python/xbox-webapi[${PYTHON_USEDEP}]
	>=dev-python/ecdsa-0.19[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.25.1[${PYTHON_USEDEP}]
	>=dev-python/ms-cv-0.1.1[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.12[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
