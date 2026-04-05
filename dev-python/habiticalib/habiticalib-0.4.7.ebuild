# Copyright 1999-2026 Gentoo Authors
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
	>=dev-python/aiohttp-3.13.4[${PYTHON_USEDEP}]
	>=dev-python/mashumaro-3.20[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.11.7[${PYTHON_USEDEP}]
	>=dev-python/pillow-12.1.1[${PYTHON_USEDEP}]
	>=dev-python/mypy-1.19.1[${PYTHON_USEDEP}]
	>=dev-python/aioresponses-0.7.8[${PYTHON_USEDEP}]
	>=dev-python/syrupy-5.1.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
