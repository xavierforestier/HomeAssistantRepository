# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Databricks SDK for Python (Beta)"
HOMEPAGE="https://pypi.org/project/databricks-sdk/"

LICENSE="Apache"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/requests-2.28.1[${PYTHON_USEDEP}]
	>=dev-python/google-auth-2.0[${PYTHON_USEDEP}]
	>=dev-python/protobuf-4.25.8[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
