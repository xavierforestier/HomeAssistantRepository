# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_13 )

inherit distutils-r1 pypi

DESCRIPTION="Super fast semantic router for AI decision making"
HOMEPAGE="https://pypi.org/project/semantic-router/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/pydantic-2.10.2[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.25.2[${PYTHON_USEDEP}]
	>=dev-python/colorlog-6.8.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0.1[${PYTHON_USEDEP}]
	>=dev-python/aurelio-sdk-0.0.19[${PYTHON_USEDEP}]
	>=dev-python/colorama-0.4.6[${PYTHON_USEDEP}]
	>=dev-python/regex-2023.12.25[${PYTHON_USEDEP}]
	>=dev-python/tiktoken-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.10.11[${PYTHON_USEDEP}]
	>=dev-python/tornado-6.4.2[${PYTHON_USEDEP}]
	>=dev-python/urllib3-1.26[${PYTHON_USEDEP}]
	>=dev-python/litellm-1.61.3[${PYTHON_USEDEP}]
	>=dev-python/openai-1.10.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
