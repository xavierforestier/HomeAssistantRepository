# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Weather alerts for European regions from MeteoAlarm.org. A maintained fork of meteoalertapi."
HOMEPAGE="https://github.com/mastermc0/meteoalarmapi https://pypi.org/project/meteoalarmapi"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest