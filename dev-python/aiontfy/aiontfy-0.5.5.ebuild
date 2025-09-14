# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Async ntfy client library"
HOMEPAGE="https://pypi.org/project/aiontfy/ https://github.com/tr4nt0r/aiontfy"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/mypy-1.17.1[${PYTHON_USEDEP}]
	>=dev-util/ruff-0.12.9
	>=dev-python/pytest-8.4.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-cov-6.2.1[${PYTHON_USEDEP}]
	>=dev-python/mkdocs-material-9.6.17[${PYTHON_USEDEP}]
	>=dev-python/pytest-asyncio-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.12.15[${PYTHON_USEDEP}]
	>=dev-python/ipykernel-6.29.5[${PYTHON_USEDEP}]
	>=dev-vcs/pre-commit-4.3.0
"

distutils_enable_tests pytest
