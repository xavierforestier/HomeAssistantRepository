# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python classes generated from the GTFS-realtime protocol buffer specification."
HOMEPAGE="https://github.com/MobilityData/gtfs-realtime-bindings https://pypi.org/project/gtfs-realtime-bindings/"

LICENSE="1pache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	dev-python/protobuf[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
