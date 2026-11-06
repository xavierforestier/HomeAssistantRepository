# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=dummy
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Async API client for Solyx Energy devices"
HOMEPAGE="https://github.com/openremote/solyx-homeassistant-integration https://pypi.org/project/solyx-energy-api-client"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest