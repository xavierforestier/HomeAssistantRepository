# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="Module which allows pythonistas to interact with iCloud webservices."
HOMEPAGE="https://github.com/timlaing/pyicloud https://pypi.org/project/pyicloud/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

#DOCS="README.rst"

RDEPEND="
	>=dev-python/certifi-2026.4.22[${PYTHON_USEDEP}]
	>=dev-python/cryptography-44.0.0[${PYTHON_USEDEP}]
	>=dev-python/fido2-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/keyring-25.7.0[${PYTHON_USEDEP}]
	>=dev-python/keyrings-alt-5.0.2[${PYTHON_USEDEP}]
	>=dev-python/protobuf-6.32.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.13.4[${PYTHON_USEDEP}]
	>=dev-python/requests-2.31.0[${PYTHON_USEDEP}]
	>=dev-python/srp-1.0.22[${PYTHON_USEDEP}]
	>=dev-python/tinyhtml-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/tzlocal-5.3.1[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
