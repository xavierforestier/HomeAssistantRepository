# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
PYPI_NO_NORMALIZE=1
inherit distutils-r1 pypi

DESCRIPTION="Python implementation of the Engine.IO realtime server"
HOMEPAGE="https://python-engineio.readthedocs.io/ https://github.com/bdraco/python-engineio-v3/ https://pypi.org/project/python-engineio-v3/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/aiohttp-3.4[${PYTHON_USEDEP}]
	>=dev-python/requests-2.21.0[${PYTHON_USEDEP}]
	>=dev-python/simple-websocket-0.10.0[${PYTHON_USEDEP}]
	>=dev-python/websocket-client-0.54.0[${PYTHON_USEDEP}]
"
# Can use eventlet, werkzeug, or gevent, but no tests for werkzeug
BDEPEND="
	test? (
		dev-python/tornado[${PYTHON_USEDEP}]
		dev-python/websockets[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-asyncio )
distutils_enable_tests pytest
distutils_enable_sphinx docs \
	dev-python/alabaster

EPYTEST_IGNORE=(
	# eventlet is masked for removal
	tests/common/test_async_eventlet.py
)

EPYTEST_DESELECT=(
	# also eventlet
	tests/common/test_server.py::TestServer::test_async_mode_eventlet
	tests/common/test_server.py::TestServer::test_connect
	tests/common/test_server.py::TestServer::test_service_task_started
	tests/common/test_server.py::TestServer::test_upgrades
)
