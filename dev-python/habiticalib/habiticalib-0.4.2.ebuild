# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous Python client library for the Habitica API"
HOMEPAGE="https://pypi.org/project/habiticalib/ https://github.com/tr4nt0r/habiticalib"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.12.15[${PYTHON_USEDEP}]
	>=dev-python/mashumaro-3.16[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.11.1[${PYTHON_USEDEP}]
	>=dev-python/pillow-11.3.0[${PYTHON_USEDEP}]
	>=dev-python/mypy-1.17.1[${PYTHON_USEDEP}]
	>=dev-util/ruff-0.12.8
	>=dev-python/pytest-8.4.1[${PYTHON_USEDEP}]
	>=dev-python/pytest-cov-6.2.1[${PYTHON_USEDEP}]
	>=dev-python/mkdocs-material-9.6.16[${PYTHON_USEDEP}]
	>=dev-python/mkdocstrings-0.30.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-asyncio-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/aioresponses-0.7.8[${PYTHON_USEDEP}]
	>=dev-vcs/pre-commit-4.3.0
	>=dev-python/syrupy-4.9.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
