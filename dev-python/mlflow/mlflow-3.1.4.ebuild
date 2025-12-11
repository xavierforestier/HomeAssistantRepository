# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="MLflow is an open source platform for the complete machine learning lifecycle"
HOMEPAGE="https://github.com/mlflow/mlflow https://pypi.org/project/mlflow/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/alembic[${PYTHON_USEDEP}]
	dev-python/cachetools[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/cloudpickle[${PYTHON_USEDEP}]
	dev-python/databricks-sdk[${PYTHON_USEDEP}]
	dev-python/docker[${PYTHON_USEDEP}]
	dev-python/fastapi[${PYTHON_USEDEP}]
	>=dev-python/gitpython-3.1.9[${PYTHON_USEDEP}]
	media-libs/graphene
	www-servers/gunicorn[${PYTHON_USEDEP}]
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-api-1.9.0[${PYTHON_USEDEP}]
	>=dev-python/opentelemetry-sdk-1.9.0[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	>=dev-python/protobuf-3.12.0[${PYTHON_USEDEP}]
	>=dev-python/pyarrow-4.0.0[${PYTHON_USEDEP}]
	>=dev-python/pydantic-1.10.8[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.17.3[${PYTHON_USEDEP}]
	dev-python/scikit-learn[${PYTHON_USEDEP}]
	dev-python/scipy[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/sqlparse-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.0.0[${PYTHON_USEDEP}]
	dev-python/uvicorn[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
