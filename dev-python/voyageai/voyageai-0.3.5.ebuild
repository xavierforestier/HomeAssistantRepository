# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Voyage AI provides cutting-edge embedding and rerankers."
HOMEPAGE="https://pypi.org/project/voyageai/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/tenacity[${PYTHON_USEDEP}]
	>=dev-python/numpy-2.1.0[${PYTHON_USEDEP}]
	dev-python/aiolimiter[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.10.8[${PYTHON_USEDEP}]
	>=sci-ml/tokenizers-0.14.0
	>=dev-python/langchain-text-splitters-0.3.8[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
