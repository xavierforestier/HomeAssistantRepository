#!/sbin/openrc-run
# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

description="Open-source home automation platform"

user="homeassistant:homeassistant"

stdoutlog="/var/log/homeassistant/stdout.log"
serverlog="/var/log/homeassistant/server.log"
warningslog="/var/log/homeassistant/warnings.log"
retry="20"

start_stop_daemon_args="--user $user --stdout $stdoutlog --stderr $serverlog --wait 10"

command="/usr/bin/hass"
command_args="
	--config /etc/homeassistant
	--log-file $warningslog
	--log-rotate-days 9
        ${HASS_OPTS}
"

command_background=yes
pidfile=/run/homeassistant.pid
# Bluetooth adapter management needs them; /etc/conf.d/homeassistant can
# override this default
capabilities="${capabilities-^cap_net_admin,^cap_net_raw}"

depend() {
    need net
    after apcupsd asterisk bluetooth cups dhcp esphome influxdb mosquitto mysql netdata prometheus socat-zwave syncthing unifi upsd xabbix zigbee2mqtt zoneminder
}

start_pre() {
    checkpath --file --owner $user --mode 0644 $stdoutlog
    checkpath --file --owner $user --mode 0644 $serverlog
    checkpath --file --owner $user --mode 0644 $warningslog
}
