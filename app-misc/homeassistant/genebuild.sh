#!/bin/bash

######
# Author: Xavier FORESTIER
# Source: https://github.com/xavierforestier/HomeAssistantRepository
# Purpose: Generate gentoo ebuild for homeassistant
#          Parse files requirement_all.txt, package_constraints.txt, and use eix to search for mathcing gentoo package
######

# parse parameters
VERSION=$( curl -s https://api.github.com/repos/home-assistant/core/releases/latest | jq '.tag_name' | xargs -I {} echo {} )

while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      echo -e "\e[1;34musage:\e[0;35m genebuild.sh [-h|--help] [-d|--delete] [-m|--metadata] [VERSION]\e[0m\n\ngenerate homeassistant ebuild\n"
      echo -e "\e[1;34moptions:\e[0m"
      echo -e "  \e[1;36m-h  --help\e[0m     display help and quit"
      echo -e "  \e[1;36m-d  --delete\e[0m   remove existing ebuild"
      echo -e "  \e[1;36m-m  --metadata\e[0m update metadata.xml"
      echo "  [VERSION]      regen a given version (default is last one available in github)"
      exit
      ;;
    -d|--delete)
      DELETE_FIRST="X"
      shift
      ;;
    -m|--metadata)
      FETCH_METADATA="X"
      shift
      ;;
    *)
      VERSION=$( curl -s "https://api.github.com/repos/home-assistant/core/releases/tags/${1/_beta/b}" | jq '.tag_name' | xargs -I {} echo {} )
      shift
      ;;
  esac
done

eix-update
EBUILD=$( pwd | rev | cut -d/ -f1 | rev )-${VERSION/b/_beta}
EBUILD_PATH=$( pwd )/$EBUILD.ebuild

test -n "$DELETE_FIRST" && test -e "${EBUILD_PATH}" && rm "${EBUILD_PATH}"

######
# Parse a requirement.txt single entry and write it in ebuild as requirement
# $1 prefix (ex "\n\t", " ")
# $2 ebuild path
# $3 requirement to parse
# Ex1: "adb-shell[async]>=0.4.4" => ">=dev-python/adb-shell-0.4.4[async,${PYTHON_USEDEP}]"
# Ex2: "xmltodict==0.13.4" => "~dev-python/xmltodict-0.13.4[${PYTHON_USEDEP}]"
######
parse_package() {
  local l="$3"
  local OIFS="$IFS"
  local operator=
  local version=
  IFS='~<>=!['
  for d in $l; do
    echo -ne "\r                                                                                        \r \e[0;32m*\e[0m Parsing dependencies... $d"
    local pos=${#d}
    if [ "${l:$pos:1}" = "[" ]; then
      operator=$( echo "$l" | cut -d] -f2- )
      #TODO version can be coma separated adb-shell[async]>=0.4.4,<5, for now only handle first criteria
      version=$( echo "${operator:2}" | cut -d\; -f1 | cut -d, -f1 )
      operator=${operator:0:2}
    else
      operator=${l:$pos:2}
      pos=$((pos + 2 ))
      version=$( echo "${l:$pos}" | cut -d\; -f1 )
    fi
    local package
    package=$( eix -es# "$d" --use python_targets_python3_14 )
    dlower=${d,,}
    if [ -z "$package" ];then
      package=$( eix -es# "${d,,}" --use python_targets_python3_14 )
    fi
    if [ -z "$package" ];then
      package=$( eix -es# "${dlower//_/-}" --use python_targets_python3_14 )
    fi
    if [ -z "$package" ];then
      package=$( eix -es# "${dlower//./-}" --use python_targets_python3_14 )
    fi
    case $d in
      atomicwrites-homeassistant)
        package="dev-python/atomicwrites"
	;;
      uv)
        echo -e "$1>=dev-python/uv-$version" >> "$2"
        break
        ;;
    esac
    if [ -z "$package" ];then
      echo -e ": \e[1;33m$l corresponding gentoo package was not found, entry skipped\e[0m                     "
      break
    fi
    #Write ebuild dep
    if [ "$version" = "1000000000.0.0" ]; then
      echo -ne "$1" >> "$2"
      echo -n "$package" >> "$2"
      break
    fi
    case $operator in
      ~= | ==)
        if [[ $version == *-* ]]; then
          echo -ne "$1" >> "$2"
          echo -n "=$package-$version" >> "$2"
	else
          echo -ne "$1" >> "$2"
          echo -n "~$package-$version" >> "$2"
	fi
	;;
      !=)
	break
	;;
      *)
        echo -ne "$1" >> "$2"
        echo -n "$operator$package-$version" >> "$2"
    esac

    local dep_use
    dep_use=$( echo "$dep" | cut -sd[ -f2 | cut -sd] -f1 )
    if [ "$dep_use" = "" ]; then
      echo -n "" >> "$2"
    else
      echo -n "[$dep_use]" >> "$2"
    fi
    break
  done
  IFS="$OIFS"
} #parse_package

######
# Parse package_constraints files for main dependencies
# $1 ebuild path
# $2 parse_constraints file
######
parse_constraints() {
  local f=$2
  echo "# Home Assistant Core dependencies from $f" >> "$1"
  echo "RDEPEND=\"\${RDEPEND}" >> "$1"
  while read -r l; do
    echo -ne "                                                                                          \r \e[0;32m*\e[0m Parsing main dependencies... $l"
    parse_package "\n\t" "$1" "$l"
  done < <( grep '^[^#]' "$f" | cut -d, -f1 | tr ' ' '\n' )
  echo "\"" >> "$1"
} #parse_constraints

######
# Parse requirment_all file and search dependencies for the given USE flag
# $1 ebuild_path
# $2 requirement_all.txt path
# $3 USE flag#
######
parse_use_flag_req() {
  local reqall=$2
  local use=$3
  local OLDIFS=$IFS
  IFS="
"
  echo -ne "                                                                                          \r \e[0;32m*\e[0m Parsing use flag dependencies... $use"
  found_dep=
  while read -r req; do
    local start_line
    start_line=$( echo "$req" | cut -d: -f1 )
    start_line=$(( start_line + 1 ))
    local found=
    for dep in $( tail -n+$start_line "$reqall" ); do
      if [ "${dep:0:1}" = "#" ]; then
        if [ "$found" = "" ]; then
          continue
        else
          break
        fi
      else
        if [ "$found_dep" = "" ]; then
          echo -ne "\t$use? (" >> "$1"
          found_dep="X"
        fi
        parse_package " " "$1" "$dep"
        found="X"
      fi
    done
  done < <( grep -n -e "^# homeassistant.components.$use$" -e "^# homeassistant.components.${use//-/_}$" "$reqall" )
  IFS=$OLDIFS

  if [ "$found_dep" = "" ]; then
    echo -e ": \e[0;31mno package found\e[0m                                     "
  else
    echo " )">> "$1"
  fi
} #parse_use_flag_req

if [ -f "$EBUILD_PATH" ]; then
    echo -e "  \e[0;31m$EBUILD already exists, \e[0m"
    ebuild "$EBUILD_PATH" clean unpack
else
    for v in $( find ./home*-2*.ebuild | sort -rV | head -n1 ); do
        cp "$v" "$EBUILD_PATH"
        break
    done
    ebuild "$EBUILD_PATH" clean digest unpack
    patch="$( pwd )/files/genebuild_${VERSION/b/_beta}.patch"
fi

pushd "/var/tmp/portage/app-misc/${EBUILD}/work" || exit
wget -q "https://raw.githubusercontent.com/home-assistant/core/refs/tags/${VERSION}/homeassistant/package_constraints.txt"
wget -q "https://raw.githubusercontent.com/home-assistant/core/refs/tags/${VERSION}/requirements_all.txt"

if [ -f "$patch" ]; then
  patch -p1 < "$patch"
fi

#gen metadata
popd || exit
if [ -n "${FETCH_METADATA}" ]; then
  echo "Generate metadata.xml..."
  sed -z 's/<use>.*/<use>/g' < metadata.xml > metadata.xml.pre
  mv metadata.xml.pre metadata.xml
  for f in $( find "/var/tmp/portage/app-misc/${EBUILD}/work/homeassistant-${VERSION}/homeassistant/components" | grep manifest.json | sort ); do
    #component name
    use_flag=$( echo "$f"| rev | cut -d/ -f2 | rev )
    if grep -qn "^# homeassistant.components.${use_flag}$" "/var/tmp/portage/app-misc/${EBUILD}/work/requirements_all.txt"; then
      #get help page
      if [ ! -f "/tmp/$use_flag.html" ]; then
        wget -q -O "/tmp/$use_flag.html" "https://www.home-assistant.io/integrations/$use_flag/index.html"
      fi
      if [ -s "/tmp/$use_flag.html" ]; then
        echo -ne "\r                                                                                          \r \e[0;32m*\e[0m Generate metadata.xml($use_flag)..."
        #parse description Ignore anything before '<div class="page-content">' then before '</header>' until '</p>', cleanup html and carriage return
        description=$( sed -z 's/.*<div class="page-content">//g' "/tmp/$use_flag.html" | sed -z 's/.*<\/header>//' | sed -z 's/<\/p>.*//' |sed -z 's/<span class="terminology-tooltip">.*<\/span>//g' | sed 's/<[^>]*>//g' | tr -d "\n" | xargs )
        echo -ne "\n    <flag name=\"${use_flag//_/-}\">$description</flag>" >> metadata.xml
      fi
    fi
  done
  cat >> metadata.xml << EOF
    <flag name="bh1750">bh1750</flag>
    <flag name="blinkt">blinkt</flag>
    <flag name="bme280">bme280</flag>
    <flag name="bme680">bme680</flag>
    <flag name="cli">cli</flag>
    <flag name="dht">dht</flag>
    <flag name="mariadb">mariadb</flag>
    <flag name="mosquitto">mosquitto</flag>
    <flag name="smarthab">smarthab</flag>
    <falg name="socat"socat</flag>
    <flag name="tesla">tesla</flag>
    <flag name="wink">wink</flag>
  </use>
</pkgmetadata>
EOF
fi

#Gen ebuild
cat > "$EBUILD_PATH" << EOF
# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_14 )
DISTUTILS_SINGLE_IMPL=python3_14
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 pypi readme.gentoo-r1 systemd

DESCRIPTION="Open-source home automation platform running on Python."
HOMEPAGE="https://home-assistant.io/ https://pypi.org/project/homeassistant https://github.com/home-assistant/core https://github.com/xavierforestier/HomeAssistantRepository"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm arm64 x86"
EOF
echo -n "IUSE=\"bh1750 blinkt bme280 bme680 cli dht http mariadb mosquitto mysql smarthab socat somfy ssl systemd tesla wink" >> "$EBUILD_PATH"

grep "\<flag" "metadata.xml" | cut -d\" -f2 | while read -r u; do 
  case $u in
    ruuvi-gateway | shelly)
      echo -n " +$u" >>"$EBUILD_PATH"
      ;;
    *)
      echo -n " ${u//_/-}" >>"$EBUILD_PATH"
  esac
done
cat >> "$EBUILD_PATH" <<EOF
"
RESTRICT="!test? ( test )"

# external deps
RDEPEND="\${PYTHON_DEPS} acct-group/\${PN} acct-user/\${PN}
	app-admin/logrotate
	dev-db/sqlite
	dev-libs/libfastjson
	dev-libs/xerces-c"
REQUIRED_USE="bluetooth? ( ruuvi-gateway shelly )
	homekit-controller? ( bluetooth )"
EOF
echo -e "\n \e[0;32m*\e[0m Parsing main dependencies..."
pushd "/var/tmp/portage/app-misc/${EBUILD}/work" || exit

parse_constraints "$EBUILD_PATH" "/var/tmp/portage/app-misc/${EBUILD}/work/package_constraints.txt" 
echo -e "                                                                                          \r \e[0;32m*\e[0m Parsing main dependencies... \e[0;32mdone\e[0m                                    "
cat >> "$EBUILD_PATH" <<EOF

# Module requirements from useflags
RDEPEND="\${RDEPEND}
	bh1750? ( dev-python/i2csense )
	blinkt? ( ~dev-python/blinkt-0.1.0 )
	bme280? ( dev-python/i2csense dev-python/bme280spi )
	bme680? ( dev-python/bme680 )
	cli? ( app-misc/home-assistant-cli )
	dht? ( ~dev-python/adafruit-circuitpython-dht-3.7.0 ~dev-python/rpi-gpio-0.7.1_alpha4 )
	http? ( dev-python/aiohttp ~dev-python/aiohttp-fast-url-dispatcher-0.3.0 ~dev-python/aiohttp-zlib-ng-0.3.1 )
	mariadb? ( dev-python/mysqlclient )
	mosquitto? ( app-misc/mosquitto )
	mysql? ( dev-python/mysqlclient )
	smarthab? ( ~dev-python/smarthab-0.21 )
	socat? ( net-misc/socat )
	somfy? ( ~dev-python/pymfy-0.11.0 )
	ssl? ( dev-libs/openssl app-crypt/certbot net-proxy/haproxy )
	tesla? ( ~dev-python/teslajsonpy-0.18.3 )
	wink? ( ~dev-python/pubnubsub-handler-1.0.9 ~dev-python/python-wink-1.10.5 )
EOF
grep "IUSE=" "$EBUILD_PATH" | cut -d\" -f2 | tr ' ' '\n' | while read -r use; do
  parse_use_flag_req "$EBUILD_PATH" "/var/tmp/portage/app-misc/${EBUILD}/work/requirements_all.txt" "${use/+/}"
done
echo "\"" >> "$EBUILD_PATH"
echo -e "                                                                                          \r \e[0;32m*\e[0m Parsing use flag dependencies... \e[0;32mdone\e[0m                        "
cat >> "$EBUILD_PATH" <<EOF

BDEPEND="\${RDEPEND}
	test? (
		dev-python/astroid
		dev-python/coverage
		dev-python/freezegun
		dev-python/mock-open
		dev-python/mypy-dev
		dev-python/pipdeptree
		dev-vcs/pre-commit
		dev-python/pylint-per-file-ignores
		dev-python/pylint
		dev-python/pytest-asyncio
		dev-python/pytest-cov
		dev-python/pytest-freezer
		dev-python/pytest-github-actions-annotate-failures
		dev-python/pytest-picked
		dev-python/pytest-socket
		dev-python/pytest-sugar
		dev-python/pytest-timeout
		dev-python/pytest-unordered
		dev-python/pytest-xdist
		dev-python/pytest
		dev-python/requests-mock
		dev-python/respx
		dev-python/syrupy
		dev-python/tqdm
	)
"

src_prepare() {
	# Dependencies with esphome is a nightmare, disable version check
	sed -ie 's/"aioesphomeapi==/"aioesphomeapi>=/g' "\${WORKDIR}/\${P}/homeassistant/components/esphome/manifest.json"
EOF
grep "IUSE=" "$EBUILD_PATH" | cut -d\" -f2 | tr ' ' '\n' | while read -r use; do
  test -d "/var/tmp/portage/app-misc/${EBUILD}/work/${EBUILD}/homeassistant/components/${use/+/}/" && echo "	use ${use/+/} || rm -r \"\${WORKDIR}/\${P}/homeassistant/components/${use/+/}/\"" >> "$EBUILD_PATH"
done
cat >> "$EBUILD_PATH" <<EOF
	distutils-r1_src_prepare
}
INSTALL_DIR="/opt/\${PN}"

DISABLE_AUTOFORMATTING=1
DOC_CONTENTS="
The HA interface listens on port 8123
hass configuration is in: /etc/\${PN}
daemon command line arguments are configured in: /etc/conf.d/\${PN}
logging is to: /var/log/\${PN}/{server,errors,stdout}.log
The sqlite db is by default in: /etc/\${PN}
"

DOCS="README.rst"

python_install_all() {
	dodoc \${DOCS}
	distutils-r1_python_install_all
	keepdir "\$INSTALL_DIR"
	keepdir "/etc/\${PN}"
	fowners -R "\${PN}:\${PN}" "/etc/\${PN}"
	keepdir "/var/log/\${PN}"
	fowners -R "\${PN}:\${PN}" "/var/log/\${PN}"
	newconfd "\${FILESDIR}/\${PN}.conf.d" "\${PN}"
	newinitd "\${FILESDIR}/\${PN}.init.d" "\${PN}"
	use systemd && systemd_dounit "\${FILESDIR}/\${PN}.service"
	dobin "\${FILESDIR}/hasstest"
	if use socat ; then
		newinitd "\${FILESDIR}/socat-zwave.init.d" "socat-zwave"
		sed -i -e 's/# need socat-zwave/need socat-zwave/g' "\${D}/etc/init.d/\${PN}" || die
	fi
	if use mqtt ; then
		sed -i -e 's/# need mosquitto/need mosquitto/g' "\${D}/etc/init.d/\${PN}" || die
	fi
	if use cli ; then
		echo -e "stop() {\n\tebegin Stoping homeassistant\n\thass-cli --token \\\${HASS_TOKEN} -s \\\${HASS_SERVER} service call homeassistant.stop\n\tsleep .5\n\tstart-stop-daemon -K \\\$command --pidfile \\\$pidfile\n\teend\n}" >> "\${D}/etc/init.d/\${PN}"
	fi
	insinto /etc/logrotate.d
	newins "\${FILESDIR}/\${PN}.logrotate" "\${PN}"
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}

distutils_enable_tests pytest
EOF

popd || exit
ebuild "$EBUILD_PATH" clean digest
