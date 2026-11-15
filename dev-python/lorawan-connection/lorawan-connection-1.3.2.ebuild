# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Backend-neutral LoRaWAN events and device collections for Python."
HOMEPAGE="https://github.com/home-assistant-libs/lorawan-connection https://pypi.org/project/lorawan-connection"
IUSE="chirpstack tts"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	chirpstack? (
		>=dev-python/chirpstack-api-4.19.0[${PYTHON_USEDEP}]
	)
	tts? (
		>=dev-python/grpcio-1.76[${PYTHON_USEDEP}]
		>=dev-python/protobuf-6.31[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
