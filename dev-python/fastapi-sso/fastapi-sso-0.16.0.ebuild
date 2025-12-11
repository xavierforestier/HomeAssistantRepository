# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="FastAPI plugin to enable SSO to most common providers"
HOMEPAGE="https://github.com/tomasvotava/fastapi-sso https://pypi.org/project/fastapi-sso/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/fastapi-0.80[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.23.0[${PYTHON_USEDEP}]
	>=dev-python/oauthlib-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.8.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
