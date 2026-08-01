# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi
DESCRIPTION="Async client for aws services using botocore and aiohttp"
HOMEPAGE="https://github.com/aio-libs/aiobotocore https://pypi.org/project/aiobotocore/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="awscli boto3 test"
RESTRICT="!test? ( test )"

DOCS="README.rst"

RDEPEND="
	>=dev-python/aiohttp-3.12.0[${PYTHON_USEDEP}] <dev-python/aiohttp-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/aioitertools-0.5.1[${PYTHON_USEDEP}] <dev-python/aioitertools-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/botocore-1.42.90[${PYTHON_USEDEP}] <dev-python/botocore-1.43.1[${PYTHON_USEDEP}]
	>=dev-python/python-dateutil-2.1.0[${PYTHON_USEDEP}] <dev-python/python-dateutil-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/jmespath-0.7.1[${PYTHON_USEDEP}] <dev-python/jmespath-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/multidict-6.0.0[${PYTHON_USEDEP}] <dev-python/multidict-7.0.0[${PYTHON_USEDEP}]
	>=dev-python/wrapt-1.10.10[${PYTHON_USEDEP}] <dev-python/wrapt-2.0.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
