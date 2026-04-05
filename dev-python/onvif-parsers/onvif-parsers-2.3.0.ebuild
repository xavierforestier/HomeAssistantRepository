# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Parsers for ONVIF events"
HOMEPAGE="https://github.com/openvideolibs/onvif-parsers https://pypi.org/project/onvif-parsers"

LICENSE="Apache2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/lxml-6.0.0
	>=dev-python/onvif-zeep-async-4.0.4
	>=dev-python/zeep-4.3.2
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
