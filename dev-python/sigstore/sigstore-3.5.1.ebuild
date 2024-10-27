# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517=flit
inherit distutils-r1 pypi

DESCRIPTION="A tool for generating and verifying Sigstore signatures."
HOMEPAGE="https://www.sigstore.dev https://github.com/sigstore/sigstore-python https://pypi.org/project/sigstore/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

RDEPEND=">=dev-python/cryptography-42.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.6[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-2.1.0[${PYTHON_USEDEP}]
	>=dev-python/pyopenssl-23.0.0[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/rfc8785[${PYTHON_USEDEP}]
	dev-python/sigstore-protobuf-specs[${PYTHON_USEDEP}]
	dev-python/sigstore-rekor-types[${PYTHON_USEDEP}]
	dev-python/tuf[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
