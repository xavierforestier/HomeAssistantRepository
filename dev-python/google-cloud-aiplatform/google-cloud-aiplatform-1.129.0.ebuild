# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Vertex AI API client library"
HOMEPAGE="https://github.com/googleapis/python-aiplatform https://pypi.org/project/google-cloud-aiplatform/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/google-api-core-1.34.1[${PYTHON_USEDEP}]
	>=dev-python/google-auth-2.14.1[${PYTHON_USEDEP}]
	>=dev-python/proto-plus-1.22.3[${PYTHON_USEDEP}]
	>=dev-python/protobuf-3.20.2[${PYTHON_USEDEP}]
	>=dev-python/packaging-14.3[${PYTHON_USEDEP}]
	>=dev-python/google-cloud-storage-1.32.0[${PYTHON_USEDEP}]
	>=dev-python/google-cloud-bigquery-1.15.0[${PYTHON_USEDEP}]
	>=dev-python/google-cloud-resource-manager-1.3.3[${PYTHON_USEDEP}]
	dev-python/shapely[${PYTHON_USEDEP}]
	>=dev-python/google-genai-1.37.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
