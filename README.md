# Home Assistant for Gentoo
## Main package version & CI/CD status
[![homeassistant-version](https://img.shields.io/badge/homeassistant-2026.3.4-lightgrey?logo=homeassistant&label=app-misc%2Fhomeassistant)](https://github.com/xavierforestier/HomeAssistantRepository/tree/master/app-misc/homeassistant)
[![zigbee2mqtt-version](https://img.shields.io/badge/zigbee2mqtt-2.9.2-238636?logo=zigbee2mqtt&label=app-misc%2Fzigbee2mqqt)](https://github.com/xavierforestier/HomeAssistantRepository/tree/master/app-misc/zigbee2mqtt)
[![esphome-version](https://img.shields.io/badge/esphome-2026.3.1-238636?logo=esphome&label=dev-embedded%2Fesphome)](https://github.com/xavierforestier/HomeAssistantRepository/tree/master/dev-embedded/esphome)
[![nodered-version](https://img.shields.io/badge/nodered-4.1.8-238636?logo=nodered&label=app-misc%2Fnode-red)](https://github.com/xavierforestier/HomeAssistantRepository/tree/master/app-misc/node-red)

## Repo activty
[![OS](https://img.shields.io/badge/OS-Gentoo%20Linux-blue)](https://www.gentoo.org/)
[![weekly commits](https://img.shields.io/github/commit-activity/w/xavierforestier/HomeAssistantRepository)](https://github.com/xavierforestier/HomeAssistantRepository/commits/)
[![monthly commits](https://img.shields.io/github/commit-activity/m/xavierforestier/HomeAssistantRepository)](https://github.com/xavierforestier/HomeAssistantRepository/commits/)

## Static Quality check 
[![shellcheck](https://img.shields.io/badge/shellcheck-shellcheck-238636?logo=github&label=)](https://github.com/xavierforestier/HomeAssistantRepository/actions/workflows/shellcheck.yml) 
[![pkgcheck](https://img.shields.io/badge/pkgcheck-pkgcheck%20(running...)-lightgrey?logo=github&label=)](https://github.com/xavierforestier/HomeAssistantRepository/actions/workflows/pkgcheck.yml) 

## Automatic emerge build status
[![homeassistant](https://img.shields.io/badge/homeassistant_minimal-homeassistant[minimal]%20(running...)-lightgrey?logo=github&label=)](https://github.com/xavierforestier/HomeAssistantRepository/actions/workflows/homeassistant.yml)
[![homeassistant](https://img.shields.io/badge/homeassistant_normal-homeassistant[normal]%20(running...)-lightgrey?logo=github&label=)](https://github.com/xavierforestier/HomeAssistantRepository/actions/workflows/homeassistant.yml)
[![homeassistant](https://img.shields.io/badge/homeassistant_full-homeassistant[full]%20(running...)-lightgrey?logo=github&label=)](https://github.com/xavierforestier/HomeAssistantRepository/actions/workflows/homeassistant.yml)

[![zigbee2mqtt](https://img.shields.io/badge/zigbee2mqttjob-zigbee2mqtt-238636?logo=github&label=)](https://github.com/xavierforestier/HomeAssistantRepository/actions/workflows/zigbee2mqtt.yml)
[![esphome](https://img.shields.io/badge/esphomejob-esphome-238636?logo=github&label=)](https://github.com/xavierforestier/HomeAssistantRepository/actions/workflows/esphome.yml)
[![nodered](https://img.shields.io/badge/noderedjob-nodered-238636?logo=github&label=)](https://github.com/xavierforestier/HomeAssistantRepository/actions/workflows/nodered.yml)

## without Docker & Virtual Environments

https://www.home-assistant.io/
https://github.com/home-assistant/home-assistant

"Open source home automation that puts local control and privacy first."

## app-misc/homeassistant-2026.3.x

Finally!!!!

2026.3.x introduces python 3.14, such huge changes !

Make sure to move first your gentoo to python 3.14 :
```bash
emerge eselect-python
echo -e "*/* PYTHON_TARGETS: -* python3_13 python3_14\n*/* PYTHON_SINGLE_TARGET: -* python3_14" > /etc/portage/package.use/python.use
emerge --deep --newuse --with-bdeps=y @world
eselect python update
echo -e "*/* PYTHON_TARGETS: -* python3_14\n*/* PYTHON_SINGLE_TARGET: -* python3_14"  > /etc/portage/package.use/python.use
emerge --deep --newuse --with-bdeps=y @world
```
then you can go  :
```bash
eix-sync
emerge homeassistant -uva
```

On the the backoffice, I rework most deps.

...rewrite CI-CD in .github folder.

...and rewrite dockers too: github.com/xavierforestier/gentoo-ci/ and github.com/xavierforestier/gentoo-ci-ha
