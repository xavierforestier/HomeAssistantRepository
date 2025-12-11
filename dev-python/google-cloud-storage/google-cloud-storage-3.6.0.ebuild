# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Google Cloud Storage API client library"
HOMEPAGE="https://github.com/googleapis/python-storage https://pypi.org/project/google-cloud-storage/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/google-auth-2.26.1[${PYTHON_USEDEP}]
	>=dev-python/google-api-core-2.27.0[${PYTHON_USEDEP}]
	>=dev-python/google-cloud-core-2.4.2[${PYTHON_USEDEP}]
	>=dev-python/requests-2.22.0[${PYTHON_USEDEP}]
	>=dev-python/google-crc32c-1.1.3[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
