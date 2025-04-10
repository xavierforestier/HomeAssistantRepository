# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_13 )

inherit distutils-r1 pypi

DESCRIPTION="The Slack API Platform SDK for Python"
HOMEPAGE="https://github.com/slackapi/python-slack-sdk https://pypi.org/project/slack_sdk/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"

RDEPEND="!dev-python/slackclient"
BDEPEND=""

distutils_enable_tests pytest
