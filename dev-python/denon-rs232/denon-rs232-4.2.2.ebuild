# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=uv-build
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Async library to control Denon receivers over RS232"
HOMEPAGE="https://github.com/home-assistant-libs/denon-rs232 https://pypi.org/project/denon-rs232/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/serialx-1.2.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
