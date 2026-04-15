# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User uses to run flutter apps"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( flutter )
ACCT_USER_HOME="/opt/flutter"
acct-user_add_deps
