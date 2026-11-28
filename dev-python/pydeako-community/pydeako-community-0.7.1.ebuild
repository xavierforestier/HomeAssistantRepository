# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Discover and control Deako smart switches on the local network"
HOMEPAGE="https://github.com/pydeako-community/pydeako https://pypi.org/project/pydeako-community"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest