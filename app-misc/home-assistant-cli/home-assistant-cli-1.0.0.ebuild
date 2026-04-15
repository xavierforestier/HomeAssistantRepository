# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{13..14} )
DISTUTILS_USE_PEP517=poetry
inherit distutils-r1

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/home-assistant/home-assistant-cli.git"
else
	SRC_URI="https://github.com/home-assistant/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"
fi

DESCRIPTION="The Home Assistant Command-line Interface (hass-cli)"
HOMEPAGE="https://github.com/home-assistant/home-assistant-cli/"
EGIT_REPO_URI="https://github.com/home-assistant/home-assistant-cli.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=dev-python/aiohttp-3.13.3[${PYTHON_USEDEP}]
	>=dev-python/dateparser-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/jsonpath-ng-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/jinja2-3.1.4[${PYTHON_USEDEP}]
	>=dev-python/requests-2.31.0[${PYTHON_USEDEP}]
	>=dev-python/tabulate-0.9.0[${PYTHON_USEDEP}]
	>=dev-python/regex-2024.5.10[${PYTHON_USEDEP}]
	>=dev-python/ruamel-yaml-0.19.0[${PYTHON_USEDEP}]
	>=dev-python/click-8.1.7[${PYTHON_USEDEP}]
	>=dev-python/click-log-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/netdisco-3.0.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-25.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-python/codecov-2.0.15[${PYTHON_USEDEP}]
		>=dev-python/coveralls-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/flake8-docstrings-1.3.0[${PYTHON_USEDEP}]
		>=dev-python/flake8-3.9[${PYTHON_USEDEP}]
		>=dev-python/mock-open-1.4[${PYTHON_USEDEP}]
		>=dev-python/mypy-0.800[${PYTHON_USEDEP}]
		>=dev-python/pydocstyle-6.0.0[${PYTHON_USEDEP}]
		>=dev-python/pylint-2.7[${PYTHON_USEDEP}]
		>=dev-python/pytest-cov-2.11[${PYTHON_USEDEP}]
		>=dev-python/pytest-sugar-0.9.4[${PYTHON_USEDEP}]
		>=dev-python/pytest-timeout-2[${PYTHON_USEDEP}]
		>=dev-python/pytest-7.0.0[${PYTHON_USEDEP}]
		>=dev-python/requests-mock-1.8.0[${PYTHON_USEDEP}]
		>=dev-python/wheel-0.33.1[${PYTHON_USEDEP}]
		>=dev-python/twine-1.13.0[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
