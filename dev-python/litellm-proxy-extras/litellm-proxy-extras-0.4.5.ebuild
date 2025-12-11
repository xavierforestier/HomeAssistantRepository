# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Additional files for the LiteLLM Proxy"
HOMEPAGE="https://github.com/BerriAI/litellm https://pypi.org/project/litellm-proxy-extras/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
