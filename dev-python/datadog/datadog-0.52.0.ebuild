# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..14} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="The Datadog Python library"
HOMEPAGE="https://www.datadoghq.com https://github.com/DataDog/datadogpy https://pypi.org/project/datadog/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

#DOCS="README.md"

RDEPEND="
	>=dev-python/requests-2.6.0[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
