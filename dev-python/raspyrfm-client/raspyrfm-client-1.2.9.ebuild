# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=poetry
inherit pypi distutils-r1

DESCRIPTION="A library to send rc signals with the RaspyRFM module"
HOMEPAGE="https://github.com/markusressel/raspyrfm-client https://pypi.org/project/raspyrfm-client/"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS="README.rst"

distutils_enable_tests pytest
