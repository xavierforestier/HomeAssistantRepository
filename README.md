# Home Assistant for Gentoo
## without Docker & Virtual Environments

https://www.home-assistant.io/
https://github.com/home-assistant/home-assistant

"Open source home automation that puts local control and privacy first."

## Origin: Ireland, Home: Bavaria
Once this was a fork of Paul Healy's `https://cgit.gentoo.org/user/lmiphay.git/tree/app-misc/homeassistant-bin`, which seemed unmaintained to me. At first I just wanted to compile it for my personal use. This happened at Home Assistant 0.77 in September 2018. Some friends told me they wanted to use/see it, so I placed it on my public git server, and was caught by surprise by several hundred page views in the very first days. I'll do my best to keep it close to the official releases, though it might get slower during summers. After three months it had ~170 ebuilds, Nov 2019 > 1599 Ebuilds in > 830 packages are on file, 970 packages in 2380 Ebuilds in September 2020. As long as I certainly do not count automatically consolidated collections, this Overlay has grown to one of the largest [Gentoo Repos](https://qa-reports.gentoo.org/output/repos/) during the last year.

If you have questions or suggestions: contact me, **any** help is very welcome. If you want to help or contribute, please [join me](https://git.edevau.net/user/sign_up).

## Authors welcome
If you are an author of an integration / component or other stuff related to Home Assistant and I have your stuff not added already, please file a pull request, or just drop me a note. For adding a component, I need a release file in tar.gz or zip format. Tagged releases on GitHub are OK, but a
PyPI `SDIST` tar.gz source release would be preferred, because I can automatically merge it and it will use Gentoo's mirror system. Most of the integrations/components do both. I cannot add packages only available in wheels format. Please make sure you have a proper license assigned, selected license should be unique on all platforms (
PyPI/GitHub/Sourceforge).

## 2020/09/25: Publishing new Main Ebuilds

Since homeassistant-0.115.3 the **Main Ebuild** is released in three different stages of expansion, only *one* of them can be installed. These three only differ in the amount of USE Flags they hold. If you are new here, start with app-misc/homeassistant-min.
### `app-misc/homeassistant-min`

New Ebuild, generated for `0.115.3` and later, intended for production use, these are the USE Flags I use in production myself. These all will compile fine and are extensively tested in every release, it currently holds **78** USE Flags.

### `app-misc/homeassistant`

The Ebuild we have since `0.97.0`, ss soon as I know that at least one user is actively using a component, it will be added. These all compile fine, but some version conflicts could occure. It currently holds **276** USE Flags.

### `app-misc/homeassistant-full`

WARNING: This one currently breaks (caused by shell limitations) emerge with an 'Argument list too long' error. It compiles with a [kernel hack](https://git.edevau.net/onkelbeh/HomeAssistantRepository/issues/190#issuecomment-1002). Thanks to @gcampagnoli.
This Ebuild contains USE Flags for (nearly) all components of Home Assistant with external dependencies. Most components compile, but these are too many (for me) to run tests for all of them on a regular schedule. It holds **796** USE Flags.

A list of all components aka USEFlags is generated with every release [DOMAINTABLE.md](DOMAINTABLE.md)

### Commons for all three Main Ebuilds

Some core dependecies are pulled in from suggested USE Flags `(+)`. You should have a *good reason* to deselect suggested USE Flags. Other components are known to have issues, these are deselected `(-)` in the Ebuilds. Perhaps they compile, perhaps they run. Normally, they have dependencies which interfere with very common libraries. The suggest/deselect prefixes are the same in all three expansion stages.

Best you start using the `app-misc/homeassistant-min` Ebuild. If you have it running and your stuff is added, you should take a look in `/etc/homeassistant/deps`. This directory holds Home Assistants virtual environment. If you find anything there, you can:

 1. do nothing and let it live in the virtual environment (not suggested)
 2. install the missing dependency with `emerge -tav {dependency}`, remove the contents of `/etc/homeassistant/deps` and restart Home Assistant. If there is still something missing, it will be downloaded and installed again in the virtual enviroment. Things you install this way will be recorded in `/var/lib/portage/world`. These modules will then be maintained and updated by portage.
 3. If you get a big `/var/lib/portage/world`, you can choose to use a bigger Ebuild anytime. Remove the old one first.

## Some thoughts
* Be aware that all dependent libraries could be marked as stable here as soon as they compile. Outside HA dependencies except of portage are not tested.
* Since I use Gentoo mostly on servers, I do not use systemd, one reason to run Gentoo is that you are NOT forced to run this crap. Beginning homeassistant-2021.2.0, handling for systemd was added by request, thanks to @Tatsh for help.
* I use an own profile based on "amd64/17.1/no-multilib"
* I currently run tests only on Python 3.9, and am starting to try builds on Python 3.10.
* python-3.9.7 is set as default target.

# Bigger Changes

## ~arm64
By user request, I have populated an ~arm64 KEYWORD on all Ebuilds, which is (currently) completely untested. I know of at least two guys using it, but I got no feedback yet. Some day I will prepare a cross compile environment to build a public binary repo for Home Assistant on [Sakakis-'s Image](https://github.com/sakaki-/gentoo-on-rpi-64bit).

## ~arm
By another request, I merged ~arm KEYWORD from @ivecera on all Ebuilds at 0.117.6. This guy is running an Odroid XU4. I updated all my scripts to keep it running.

## Breaking Change: many USE Flags changed in 0.115.0

Beginning with `0.115.0_beta10` many USE Flags have changed.
All USE Flags have *exactly* the same name as the components `domain` in Home Assistant now. OK, this is a hard cut, but overdue. Mostly caused by the creation of an automated import routine, at first I planned to keep the old names, the replacement class was already written, but during data collection I discovered that the original domain names aren't so bad anyway.

Some outdated components have disappeared forever.

You will find the detailed changes in commit: https://git.edevau.net/onkelbeh/HomeAssistantRepository/commit/3fec35c803e6061e0186df2af4e914e5791b53cc, scroll down to `metadata.xml`. But `emerge` will also tell.

## Nearly all Home Assistant Components are now included
Except of some modules with uncorrectable errors (e.g. hard drive crashes, lost sources) I believe all possible integrations for Home Assistant and their stated dependencies are included as Ebuilds, based on the integrations list from `/usr/lib/python3.8/site-packages/homeassistant/components/*/manifest.json`. Many fixed dependencies (necessary or not) to old releases forbid installation of packages requiring newer ones, but I filed all dependencies strict as they have been declared in `setup.py` or `requirements.txt` (sometimes other sources) anyway. The exception proves the rule.

Currrently missing (2021.6):
* azure-eventhub-5.1.0
* azure-servicebus-0.50.1
* google-cloud-texttospeech-0.4.0 (no potential need, there are good alternatives on the market)
* google-cloud-pubsub-0.39.1
* opencv-python-headless-4.3.0.36
* pyuptimerobot-0.0.5 (unmaintained, could not find a valid source)

In some cases I added small patches to the Ebuilds, some packages have versions pinned without any reason. Mostly, I copy hard pinnings without questioning, in very problematic cases I open a ticket at the problem's origin. For me its OK, if the packages compile and complete their own tests in the sandbox. Please let me know if you encounter problems. I will continuously expand my tests and do more cleanups. I am continuously filing pull requests to reduce the amount of needed patches. Most of them are caused by missing files in SDIST archives and/or having wrong package exclude masks in `setup.py`.

# Other things you find here

Aside from Home Assistant's stuff this repo contains some Ebuilds I use with my Home Assistant, some have to be explicitly mentioned:

## ESPHome
Thanks to @OttoWinter for his fabulous idea and [great work](https://github.com/esphome/esphome), really cool stuff, as soon as your name server accepts dynamic names from DHCP, a lot of ESP devices are very easy to deploy and maintain. Its integration in Home Assistant is easy and reacts fast on state changes. I love its integration in Home Assistant, since you have one single point where you define and name a switch or a sensor (instead of > three points using MQTT). Together with the possibility of OTA updates my sensors now have a unique name everywhere in the system, and names can be changed very easily. I installed the dashboard in HA's Gui, so updates and changes are made with a few clicks. In the meantime I migrated all my Magichome Controllers, very happy with it, and I have a couple of binary input arrays running with it without any problems. However, my Sonoff POW and POW R2 are still running with various versions of Tasmota. Some [required libraries](https://github.com/esphome/feature-requests/issues/586) are too old for Home Assistants environment, and I do NOT use virtual environments, so I simply patched it, it runs on my productive system without any problems, please report if you find any. You can also use the dev Ebuild (`dev-embedded/esphome-9999.ebuild`), which uses newer libraries, but will be compiled every time you run a world update, it is also very stable most of the time.

## Platformio
Platformio is needed for ESPHome and other stuff.

# Install & Upgrade

## Git Server & Mirrors
You will find this Repository at

| Location | Web | Clone me here |
| ------ | ------ | ------ |
| Main | https://git.edevau.net/onkelbeh/HomeAssistantRepository | https://git.edevau.net/onkelbeh/HomeAssistantRepository.git |
| Mirror | https://github.com/onkelbeh/HomeAssistantRepository |  https://github.com/onkelbeh/HomeAssistantRepository.git |

Sorry, due to technical reasons, I currently cannot offer public ssh access to my git server.

Sure, you can submit **issues** and **pull requests** on both sites, but I prefer them on my own server (requires registration).

## Python versions
### Python 3.9
My production box now runs Python 3.9.6_p1 (29.8.2021). Most modules are OK with 3.9 support, some are not completed yet. I will upgrade them if they are touched, if you find your favorite components missing, just open a ticket and drop me a list. During compile tests, I have all available tests turned on.

### Python <= 3.8 Support
SOuld still work, but since Python 3.8 support is dropped, I will do no further tests on it, you should upgrade soon.

### Python 3.10 Support
Currently not usable in production, my testbox compiles a lot of modules now, but some important things are still missing.

## Installation on Python 3.9
Since Python 3.9 is default target since 05/2021, installation is very easy now.

### Let's get started:
First add the Overlay to `/etc/portage/repos.conf/homeassistant.conf`, make sure **not to interfere** with your main Gentoo repo, which is at `/usr/portage/gentoo` in my boxes, because I _always_ have more than one repo active by default. Others use `/usr/local/portage/homeassistant`
```
[HomeAssistantRepository]
location = /usr/portage/homeassistant
sync-type = git
sync-uri = https://git.edevau.net/onkelbeh/HomeAssistantRepository.git
auto-sync = yes
sync-rsync-verify-metamanifest = no
```
Sync it:
```sh
$ emerge --sync
```
Make sure you have a proper locale setting. I use
```sh
$ cat /etc/locale.gen
de_DE ISO-8859-1
de_DE@euro UTF-8
```
If you change your locales, recompile glibc.
It will make things easier if you take the example files from `/etc/portage/package.accept_keywords/99_homeassistant` and `/etc/portage/package.use/60_homeassistant` and copy it to your `/etc/portage`. The clean way is to let `portage` build your own.

Check your `/etc/portage/make.conf` to freeze correct Python Targets:
```sh
USE_PYTHON="3.9"
PYTHON_TARGETS="python3_9"
PYTHON_SINGLE_TARGET="python3_9"
```
Run `eselect python` to put Python 3.9 on position 1

Finally install Home Assistant:
```sh
$ emerge -tav app-misc/homeassistant
$ rc-update add homeassistant
```

It could be necessary to install some components by hand, there are too many components to mask all in USE Flags. If you use a component which you want to be added as a USE Flag, send a pull request, or just let me know.

## Upgrading to Python 3.9 from a pre 3.9 system (same as it was from Python 3.6 to 3.7, and 3.7 to 3.8).

### The fastest way:

* Remove app-misc/homeassistant (emerge -cav)
* run `emerge --depclean -a`, this will remove all dependent packages
* update your naked core system as described below, or just run a
```sh
$ emerge -tauvDUN @world --autounmask=y --changed-deps --changed-use --newuse --deep --with-bdeps=y
```

* reinstall app-misc/homeassistant with only the new Python Version

This avoids a lot of recompiling all Home Assistant deps, and a lot of dependency trouble. Very recommended. I did not, but I just wanted to see if the hard way works too ;-)

### The upgrade steps:

Make sure your system is up to date:
```sh
$ emerge -tauvDUN @world
```
Install Python 3.9:
```sh
$ emerge -tav dev-lang/python:3.9
```
Edit your `/etc/portage/make.conf` to set the new Python Targets, make sure you have **both** versions active now:
```sh
USE_PYTHON="3.9 3.8"
PYTHON_TARGETS="python3_9 python3_8"
PYTHON_SINGLE_TARGET="python3_9"
```

Run `eselect python` to put Python 3.8 on position 1, perhaps you'll have to edit `/etc/python-exec/python-exec.conf`.

Run the Update:
```sh
$ emerge --depclean
$ emerge -1vUD @world
$ emerge --depclean
```
If everything is clean, double check with:

* `eix --installed-with-use python_targets_python3_8` (<- old version)
* `eix --installed-without-use python_targets_python3_9` (<- new version)

or

* `diff <(equery h python_targets_python3_8) <(equery h python_targets_python3_9)`
* `diff <(equery h python_single_target_python3_8) <(equery h python_single_target_python3_9)`


Help it with:
```sh
eix -I# --installed-without-use python_targets_python3_9 | xargs emerge -1tv
```

Now you have all Python packages for both versions installed, time to get rid of the packages compiled for the old Python:

Edit your `/etc/portage/make.conf` to remove old Python Targets:
```sh
USE_PYTHON="3.9"
PYTHON_TARGETS="python3_9"
PYTHON_SINGLE_TARGET="python3_9"
```
Run the Update again:

```sh
# emerge --depclean
# emerge -1vUD @world
# emerge --depclean
```

It does not make sense to compile all this stuff **for more than one** Python target.

Check if all is gone:

```sh
# eix --installed-with-use python_targets_python3_8
```

Recompile all packages which are still present in the old Python. Repeat until all have vanished.

### Remove the old Python

```sh
# emerge -cav /dev-lang/python:3.8
```

### Tools that might help to clean up:

```sh
$ eix --installed-with-use python_targets_python3_8
$ diff <(equery h python_targets_python3_8) <(equery h python_targets_python3_9)
```

# My VMs/boxes and Stuff I use

## My environment
I run Home Assistant on a virtual X64 box, 4GB RAM, 3 Cores of an older Xeon E5-2630 v2 @ 2.60GHz and 30GB Disk from a small FC SAN (HP MSA). Recorder writes to a local mariadb socket, moved this from my 'big' mariadb machine because of some performance issues. Influxdb and Graphana are also on the same box. I cannot imagine how someone can run this stuff an a Raspberry Pi.

## My machines
Currently I have three VM's running:
### Production
Python 3.9.7_p1
4 GB RAM, 3 cores of a Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz
### Dev / Test
Python 3.9.7_p1
4 GB RAM, 3 cores of a Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz
### Dev / Test2
Python 3.10.0_p1
4 GB RAM, 3 cores of a Intel(R) Xeon(R) Silver 4114 CPU @ 2.20GHz

## Hardware I use

Here's a rough overview about the stuff I use, sorted by USEFlags:

### androidtv
Get the Status from my Amazon Fire-TV.

### axis
Axis Camera (1, a few more to come), i do not use this integration anymore, it had a problem with my old cam's, migrated it to qvr_pro.

### caldav
Calendar (connected to a locally run ownCloud, OC not in this Repository) (https://owncloud.org/), use it for a very intelligent Alarmclock and to control heating on home office days.

### cli

### compensation

### coronavirus

### darksky
since yr.no weather was removed by YR's request in early 2021, I use darksky.

### dwd_weather_warnings 

### enigma2
Enigma2 on Dreambox (2 left) (https://wiki.blue-panel.com/index.php/Enigma2)

### esphome
ESPHome - see description above - (https://esphome.io/ & https://github.com/esphome/esphome/)
* Now all of my HC-SR501 PIR Sensors and some of my traditional light switches are connected to two big input arrays I built into old CAT6 patch panels with an ESP12 and 4 PCF8574 I2C I/O Expanders, this makes 24 I/O lines per panel. All these panels run ESPHome.
* OneWire and I2C Sensors
* Sonoff S20
* Sonoff 4ch
* Sonoff Dual
* Sonoff RF Bridge with remote Switches
* Sonoff Touch
As soon as a device with an esp inside gets touched, it will be migrated to ESPHome.

### forecast_solar
a forecast of today's solar production, only have a free account.

### fronius
query my Fronius solar inverters via their integrated wifi chip.


### github

### http

### hyperion
Hyperion with APA102 (very cool stuff) (https://hyperion-project.org/)

### influxdb
storing the temperatures from the DS18B20 (heating system & room temps).

### knx

### kodi
Kodi on Raspberry (3, all with OSMC) (https://osmc.tv/download/), very happy with it.

### kraken

### maxcube
EQ3-Max! (I accidently bought some, so I have to use them until they die, 8 devices and a cube). When a thermostat dies, it gets replaced with a devolo z-wave model.

### mikrotik
presence detection, query the connected mac addresses from the CAP AC.

### mqtt
The Sonoff Pow (and R2) will stay with Tasmota for a while, because I have no good implementation of Tasmota's energy summary in ESPHome. I have connectd these via MQTT.
Some Zigbee devices via an CC2531 USB stick from Amazon and `zigbee2mqtt`. Since zigbee2mqtt, a lot of new devices are here now:
* some Xioami motion sensors (Aquara)
* an Aquara environment sensor
* lots of Sonoff's window Sensors
* all the IKEA stuff (4 shutters, some lighting and all the buttons that came with them)

### mysql
using a local mariadb for the recorder.

### otp

### owntracks
have installed owntracks on ours Iphones, so HA knows when I leave work and if anybody is home.
### ping

### qnap

### qvr_pro

### recorder

### rest

### samsungtv
SamsungTV (partly _not_ working anymore due to Samsung's newest firmware 'improvements', at least I can read its status for controlling lights & the shutters)

### scrape

### season

### shelly
Experimenting with Shelly Devices, a friend has some Shelly 1/2, bought a Pro, but this one has a Chip from TI, no ESP, so we'll have to use the original Firmware, connected to MQTT.
Due to the fact that Fibaro's shutter controllers do not work very well, I now have a couple of Shelly 2.5 to control the shutters. These work good, looks like a 'install & forget' thing.

### signal_messenger

### snmp

### sonos
Sonos (had many, sold most of them, because they destroyed a formerly very cool Gui, only two boxes left)

### sql

### ssl

### tasmota
except some Sonoff Pow R2 all former Tasmota stuff was migrated to ESPHome. I had not yet the time to transfer the power statistics.

### test

### tradfri
Some Tradfri lights, and 4 IKEA Shutters. A bit expensive, but nice and easy to install. I do not use the Gateway anymore, the integration caused problems from time to time. I have all IKEA devices connected via zigbee2mqtt.

### version

### whois

### workday

### yamaha

### yamaha_musiccast
Yamaha RXV (4 devices)

### zwave
had a ZMEEUZB1 Stick connected to my VM with ser2net, socat & OpenZWave. Have migrated it to zwavejs2mqtt.

### zwave_js
migration was easier than expected, after finding the right module. Have some Fibaro shutter controllers and (currently) 2 devolo thermostats. I would not buy the Fibaro stuff again, because of their weird firmware policy. You need to have their expensive (and otherwise useless) gateway to make an update. The cheap chinese stuff will do better. And they are very badly shielded.

# Some background

## Why I don't (want to) use a virtual environment for Home Assistant
On Gentoo, we have a very powerful package manager. So I (now) try to put everything Home Assistant uses into Ebuilds.

Some years ago I started with only those packages Home Assistant needed absolutely to start. Home Assistant then downloads and installs modules it requires and cannot find. After some time, `/etc/homeassitant/deps` grew larger and larger, things messed up, I had a well-maintained system, except the directory where a lot of packages (also outdated ones) live without our knowledge.

So I started to add more important components as Ebuilds, I did not touch the internal requirement check. If a package is installed via `portage` and Home Assistants constraints match, Home Assistant does not download its own copy.

You can find the current constraints in:
* https://github.com/home-assistant/core/blob/dev/requirements_all.txt and
* https://github.com/home-assistant/core/blob/dev/homeassistant/package_constraints.txt

You should take a look in `/etc/homeassistant/deps/` from time to time, I do this after every upgrade, if it is not empty, install the missing package, emtpy this directory, restart Home Assistant, if it is still downloaded, possibly the wrong (mostly too new) version of a component or a library is installed. `eix`, `/etc/portage/package.accept_keywords` and `--autounmask=y` are your friends. You should not unmask too much, and think about the next releases when you unmask packages.

## Privacy
I have **no** Google, Amazon or Apple involved in my privacy (at least in this case) and I am not planning to let them in.

## Sources Missing, older release tags
Some packages with missing or hidden older releases have been [forked](https://github.com/onkelbeh?tab=repositories) after the originating author has been queried and notified. I did not touch any source, no changes except of adding the missing release tags have been made. I used these forks ONLY for generating consitent sources. If patches are needed, they will be applied during the compile process. As soon as another usable release will be available, I'll swap the `SRC_URI` back to
PyPI, the original GitHub or wherever it should come from. For every fork in use I have an open ticket at [git.edevau.net](https://git.edevau.net/onkelbeh/HomeAssistantRepository/issues).  Please drop me a [note](https://github.com/onkelbeh/HomeAssistantRepository/issues) if you find a valid origin or something wrong.

## Reporting Issues
First, please also check if your issue is already reported at [git.edevau.net](https://git.edevau.net/onkelbeh/HomeAssistantRepository/issues).

If not, please report it [here](https://git.edevau.net/onkelbeh/HomeAssistantRepository/issues) or at [GitHub](https://github.com/onkelbeh/HomeAssistantRepository/issues).

Please let me know if anything is wrong or dependencies are missing, since I use only some of the components myself.

From time to time a fresh compile test on empty boxes (one with Python 3.9 and one with Python 3.10) is run to catch general faults. Every new Ebuild has to pass all its tests, modules without tests are comitted after they compile without errors.

## To-dos
- Publish my ESPHome Configurations
- Add test support for Python 3.10
- Add more libraries of fix Python 3.9 support if I need it or someone asks for.
- Convince the world to not run Home Assistant with Docker (see https://xkcd.com/1988/)

## Experiments in progress:
* grafana with influxdb, will have to use it at work soon and have to get used to it anyway, fits much better for irregular measurements than Cacti/RRD.
* remote IOS authentication with [haproxy](https://www.haproxy.org) and client certificates.
* play with [Node-RED](https://nodered.org/), there are user requests for it, but my skills are too low for this Ebuild :-)

## Licenses
This repository itself is released under GPL-3 (like most Gentoo repositories), all work on the depending components under the licenses they came from. Perhaps you came here because I filed an issue at your component about a bad or missing license. It is easy to [assign a license](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/adding-a-license-to-a-repository). During cleanups and license investigations I have been asked often which license to choose. I am not a lawyer, but I can offer the following table, counted over this repository, perhaps this helps your decision. If a package has more than one license listed, all of them are counted.
There are 2052 Ebuilds in total, 2040 of them have in total 2055 (36 different) licenses assigned.

|License| Ebuilds using it|
|-------|-----|
|MIT|1177|
|Apache-2.0|407|
|BSD|147|
|GPL-3|128|
|LGPL-3|32|
|GPL-2|20|
|all-rights-reserved|17|
|GPL-3+|16|
|LGPL-3+|16|
|BSD-2|14|
|LGPL-2.1|12|
|Unlicense|10|
|PSF-2|9|
|MPL-2.0|7|
|EPL-1.0|4|
|HPND|4|
|AGPL-3+|3|
|LGPL-2+|3|
|LGPL-2.1+|3|
|BSD-4|3|
|public-domain|3|
|ECL-2.0|2|
|ISC|2|
|NEWLIB|2|
|EPL-2.0|2|
|GPL-2+|2|
|ZPL|1|
|LGPL-2|1|
|Boost-1.0|1|
|AGPL-3|1|
|PSF-2.3|1|
|CC-BY-NC-SA-3.0|1|
|CC-BY-NC-SA-4.0|1|
|OSL-2.0|1|
|CC0-1.0|1|
|GPL-1|1|

(Last counted: 04/11/2021)

I did my best to keep these clean. If a valid license was published on PyPI, it has been automatically merged. Otherwise I took it from GitHub or alternatively from comments/files in the source. Sometimes these differed and have been not unique. All license strings are adjusted to the list in `/usr/portage/gentoo/licenses/`. Some packages do not have any license published. In this case, Authors have been asked for clarification, some did not respond. Following the [official Gentoo Guide](https://devmanual.gentoo.org/general-concepts/licenses/index.html), these then were added with an `all-rights-reserved` license and `RESTRICT="mirror"` was set. Find the appropriate licenses referenced in the Ebuild files and in the corresponding homepages or sources.

A big thanks goes to Iris for reviewing this README.
Last updated: 04/11/2021
