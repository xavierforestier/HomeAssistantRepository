# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Tuya quirks library"
HOMEPAGE="https://github.com/home-assistant-libs/tuya-device-handlers https://pypi.org/project/tuya-device-handlers/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/tuya-device-sharing-sdk-0.2.8[${PYTHON_USEDEP}]
	>=dev-python/click-8.0.1[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
