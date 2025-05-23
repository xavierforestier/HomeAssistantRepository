# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

DESCRIPTION="Discover devices that respond on port 30303"
HOMEPAGE="https://github.com/bdraco/discovery30303 https://pypi.org/project/discovery30303/"
SRC_URI="https://github.com/bdraco/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.md"

distutils_enable_tests pytest
