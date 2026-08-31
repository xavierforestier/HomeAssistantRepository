# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Constraint-driven gazetteer matcher for Home Assistant intents"
HOMEPAGE="https://pypi.org/project/gazetteer-matcher"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/pyyaml-6.0[${PYTHON_USEDEP}]
	>=dev-python/unicode-rbnf-2.4.0[${PYTHON_USEDEP}]
	>=dev-python/home-assistant-intents-2026.8.24[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
