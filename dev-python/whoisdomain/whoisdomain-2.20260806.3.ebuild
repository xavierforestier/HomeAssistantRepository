# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Python package for retrieving WHOIS information of domains."
HOMEPAGE="https://github.com/mboot-github/WhoisDomain https://pypi.org/project/whoisdomain"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/whodap-0.1.16[${PYTHON_USEDEP}]
	>=dev-python/tld-0.13.2[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
