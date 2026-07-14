# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Asynchronous Python client for CentriConnect/MyPropane API"
HOMEPAGE="https://github.com/gresrun/aiocentriconnect https://pypi.org/project/aiocentriconnect"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohappyeyeballs-2.6.1[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.13.3[${PYTHON_USEDEP}]
	=dev-python/aiosignal-1.4.0[${PYTHON_USEDEP}]
	=dev-python/aresponses-3.0.0[${PYTHON_USEDEP}]
	=dev-python/astroid-4.0.4[${PYTHON_USEDEP}]
	>=dev-python/attrs-25.4.0[${PYTHON_USEDEP}]
	=dev-python/backoff-2.2.1[${PYTHON_USEDEP}]
	>=dev-python/black-26.3.0[${PYTHON_USEDEP}]
	>=dev-python/build-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/certifi-2026.2.25[${PYTHON_USEDEP}]
	>=dev-python/charset-normalizer-3.4.3[${PYTHON_USEDEP}]
	>=dev-python/click-8.3.1[${PYTHON_USEDEP}]
	=dev-python/dill-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/docutils-0.22.4[${PYTHON_USEDEP}]
	=dev-python/flake8-7.3.0[${PYTHON_USEDEP}]
	=dev-python/frozenlist-1.8.0[${PYTHON_USEDEP}]
	=dev-python/id-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/idna-3.11[${PYTHON_USEDEP}]
	=dev-python/iniconfig-2.3.0[${PYTHON_USEDEP}]
	=dev-python/isort-8.0.1[${PYTHON_USEDEP}]
	=dev-python/jaraco-classes-3.4.0[${PYTHON_USEDEP}]
	>=dev-python/jaraco-context-6.1.1[${PYTHON_USEDEP}]
	>=dev-python/jaraco-functools-4.4.0[${PYTHON_USEDEP}]
	=dev-python/keyring-25.7.0[${PYTHON_USEDEP}]
	>=dev-python/markdown-it-py-4.0.0[${PYTHON_USEDEP}]
	=dev-python/mccabe-0.7.0[${PYTHON_USEDEP}]
	=dev-python/mdurl-0.1.2[${PYTHON_USEDEP}]
	>=dev-python/more-itertools-10.8.0[${PYTHON_USEDEP}]
	=dev-python/multidict-6.7.1[${PYTHON_USEDEP}]
	>=dev-python/mypy-extensions-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/nh3-0.3.3[${PYTHON_USEDEP}]
	>=dev-python/packaging-26.0[${PYTHON_USEDEP}]
	>=dev-python/pathspec-1.0.4[${PYTHON_USEDEP}]
	>=dev-python/platformdirs-4.9.4[${PYTHON_USEDEP}]
	=dev-python/pluggy-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/propcache-0.4.1[${PYTHON_USEDEP}]
	=dev-python/pycodestyle-2.14.0[${PYTHON_USEDEP}]
	=dev-python/pyflakes-3.4.0[${PYTHON_USEDEP}]
	=dev-python/pygments-2.19.2[${PYTHON_USEDEP}]
	=dev-python/pylint-4.0.5[${PYTHON_USEDEP}]
	=dev-python/pyproject-hooks-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/pytest-9.0.2[${PYTHON_USEDEP}]
	>=dev-python/pytest-asyncio-1.3.0[${PYTHON_USEDEP}]
	=dev-python/pytokens-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/readme-renderer-44.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.32.5[${PYTHON_USEDEP}]
	=dev-python/requests-toolbelt-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/rfc3986-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/rich-14.3.3[${PYTHON_USEDEP}]
	=dev-python/tomlkit-0.14.0[${PYTHON_USEDEP}]
	=dev-python/twine-6.2.0[${PYTHON_USEDEP}]
	>=dev-python/urllib3-2.6.3[${PYTHON_USEDEP}]
	>=dev-python/yarl-1.23.0[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
