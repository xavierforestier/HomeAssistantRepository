# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Embeddings, Retrieval, and Reranking"
HOMEPAGE="https://github.com/huggingface/sentence-transformers/ https://pypi.org/project/sentence-transformers/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=sci-ml/transformers-4.41.0
	dev-python/tqdm[${PYTHON_USEDEP}]
	>=sci-ml/pytorch-1.11.0
	dev-python/scikit-learn[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	>=sci-ml/huggingface_hub-0.20.0
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.5.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
