# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="Library to easily interface with LLM API providers"
HOMEPAGE="https://github.com/BerriAI/litellm https://pypi.org/project/litellm/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="
	>=dev-python/fastuuid-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.23.0[${PYTHON_USEDEP}]
	>=dev-python/openai-1.99.5[${PYTHON_USEDEP}]
	>=dev-python/python-dotenv-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/tiktoken-0.7.0[${PYTHON_USEDEP}]
	>=dev-python/importlib-metadata-6.8.0[${PYTHON_USEDEP}]
	sci-ml/tokenizers
	dev-python/click[${PYTHON_USEDEP}]
	>=dev-python/jinja2-3.1.2[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.10[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.5.0[${PYTHON_USEDEP}]
	>=dev-python/jsonschema-4.22.0[${PYTHON_USEDEP}]

	>=dev-python/uvicorn-0.29.0[${PYTHON_USEDEP}]
	>=dev-python/uvloop-0.21.0[${PYTHON_USEDEP}]
	>=www-servers/gunicorn-23.0.0[${PYTHON_USEDEP}]
	>=dev-python/fastapi-0.120.1[${PYTHON_USEDEP}]
	dev-python/backoff[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-6.0.1[${PYTHON_USEDEP}]
	dev-python/rq[${PYTHON_USEDEP}]
	>=dev-python/orjson-3.9.7[${PYTHON_USEDEP}]
	>=dev-python/apscheduler-3.10.4[${PYTHON_USEDEP}]
	>=dev-python/fastapi-sso-0.16.0[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-2.8.0[${PYTHON_USEDEP}]
	>=dev-python/python-multipart-0.0.18[${PYTHON_USEDEP}]
	dev-python/cryptography[${PYTHON_USEDEP}]
	>=dev-python/azure-identity-1.15.0[${PYTHON_USEDEP}]
	>=dev-python/azure-keyvault-secrets-4.8.0[${PYTHON_USEDEP}]
	>=dev-python/azure-storage-blob-12.24.0[${PYTHON_USEDEP}]
	>=dev-python/google-cloud-kms-2.21.3[${PYTHON_USEDEP}]
	>=dev-python/google-cloud-iam-2.19.1[${PYTHON_USEDEP}]
	>=dev-python/pynacl-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/websockets-13.1.0[${PYTHON_USEDEP}]
	>=dev-python/boto3-1.36.0[${PYTHON_USEDEP}]
	>=dev-python/redisvl-0.4.1[${PYTHON_USEDEP}]
	>=dev-python/mcp-1.10.0[${PYTHON_USEDEP}]
	>=dev-python/litellm-proxy-extras-0.4.5[${PYTHON_USEDEP}]
	>=dev-python/rich-13.7.1[${PYTHON_USEDEP}]
	>=dev-python/litellm-enterprise-0.1.21[${PYTHON_USEDEP}]
	>=dev-python/diskcache-5.6.1[${PYTHON_USEDEP}]
	>=dev-python/polars-1.31.0[${PYTHON_USEDEP}]
	dev-python/semantic-router[${PYTHON_USEDEP}]
	>=dev-python/mlflow-3.1.4[${PYTHON_USEDEP}]
	>=dev-python/soundfile-0.12.1[${PYTHON_USEDEP}]
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
