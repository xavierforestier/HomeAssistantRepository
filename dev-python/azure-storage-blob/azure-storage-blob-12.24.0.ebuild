# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Microsoft Azure Blob Storage Client Library for Python"
HOMEPAGE="https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/storage/azure-storage-blob https://pypi.org/project/azure-storage-blob/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND="
	>=dev-python/azure-core-1.30.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.1.4[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.6.0[${PYTHON_USEDEP}]
	>=dev-python/isodate-0.6.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
