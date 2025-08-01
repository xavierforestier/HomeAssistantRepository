# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="A library for serializing and deserializing Sigstore messages"
HOMEPAGE="
	https://github.com/sigstore/protobuf-specs/tree/main/gen/pb-python/
	https://pypi.org/project/sigstore-protobuf-specs/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	~dev-python/betterproto-2.0.0_beta6[${PYTHON_USEDEP}]
"
