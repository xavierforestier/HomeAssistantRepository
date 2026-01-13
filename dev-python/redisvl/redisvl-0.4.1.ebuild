# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python client library and CLI for using Redis as a vector database"
HOMEPAGE="https://github.com/redis/redis-vl-python https://pypi.org/project/redisvl/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

PATCHES="${FILESDIR}/${PN}-fix-collisions.patch"

RDEPEND="
	>=dev-python/numpy-1.26.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.4[${PYTHON_USEDEP}]
	>=dev-python/coloredlogs-15.0[${PYTHON_USEDEP}]
	>=dev-python/redis-5.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2[${PYTHON_USEDEP}]
	>=dev-python/tenacity-8.2.2[${PYTHON_USEDEP}]
	>=dev-python/tabulate-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/ml-dtypes-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/python-ulid-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/openai-1.13.0[${PYTHON_USEDEP}]
	>=dev-python/sentence-transformers-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/scipy-1.15.0[${PYTHON_USEDEP}]
	>=dev-python/google-cloud-aiplatform-1.26[${PYTHON_USEDEP}]
	>=dev-python/protobuf-5.29.1[${PYTHON_USEDEP}]
	>=dev-python/cohere-4.44[${PYTHON_USEDEP}]
	>=dev-python/mistralai-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/voyageai-0.2.2[${PYTHON_USEDEP}]
	>=dev-python/boto3-1.36.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
