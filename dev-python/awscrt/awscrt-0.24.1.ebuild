# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi

DESCRIPTION="A common runtime for AWS Python projects"
HOMEPAGE="https://github.com/awslabs/aws-crt-python https://pypi.org/project/awscrt/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

src_configure() {
	export AWS_CRT_BUILD_USE_SYSTEM_LIBCRYPTO=1
}

distutils_enable_tests pytest
