# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..14} )

inherit distutils-r1 pypi

DESCRIPTION="GenAI Python SDK"
HOMEPAGE="https://github.com/googleapis/python-genai https://pypi.org/project/google-genai/"
PATCHES="${FILESDIR}/${PN}-build-system.patch"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
IUSE="+local-tokenizer"

RDEPEND="
	>=dev-python/anyio-4.8.0[${PYTHON_USEDEP}]
	>=dev-python/google-auth-2.56.0[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.28.1[${PYTHON_USEDEP}]
	>=dev-python/pydantic-2.12.5[${PYTHON_USEDEP}]
	>=dev-python/requests-2.28.1[${PYTHON_USEDEP}]
	>=dev-python/tenacity-8.2.3[${PYTHON_USEDEP}]
	>=dev-python/websockets-13.0.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-4.14.0[${PYTHON_USEDEP}]
	>=dev-python/distro-1.7.0[${PYTHON_USEDEP}]
	dev-python/sniffio[${PYTHON_USEDEP}]
	>=dev-python/aiohttp-3.10.11[${PYTHON_USEDEP}]
	dev-python/pyopenssl[${PYTHON_USEDEP}]

	local-tokenizer? (
		>=sci-ml/sentencepiece-0.2.0[${PYTHON_USEDEP}]
		dev-python/protobuf[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/torch[${PYTHON_USEDEP}]
		dev-python/torchvision[${PYTHON_USEDEP}]
		dev-python/trasnformers[${PYTHON_USEDEP}]
	)
"

src_unpack() {
	unpack "${A}"
	mv "${WORKDIR}/python-genai-${PV}" "${S}"
}

distutils_enable_tests pytest
