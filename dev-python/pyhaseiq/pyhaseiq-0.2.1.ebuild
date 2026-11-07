# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Read-only Python library for Hase iQ wood stoves, over their local WebSocket. Fully local, no cloud, no vendor app."
HOMEPAGE="https://github.com/bbayszczak/pyhaseiq https://pypi.org/project/pyhaseiq"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/websockets-15[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest