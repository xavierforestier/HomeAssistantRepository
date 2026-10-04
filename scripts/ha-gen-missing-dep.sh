#!/bin/bash

category=""
package=""
version=""

# get missing deps blocking latest app-misc/homeassistant build
# <- category : ebuild category
# <- package : ebuild name
# <- version : ebuild version
get_missing_dep() {
  local missing_dep=$( emerge -pq =app-misc/$( ls app-misc/homeassistant/*.ebuild -vr | head -n1 | rev | cut -d. -f2- | cut -d/ -f1 | rev ) 2>&1 >/dev/null | grep "emerge: there are no ebuilds to satisfy" | cut -d \" -f 2 | sed 's/^[^a-z]*//' )
  [ -z "${missing_dep}" ] && return 1
  category=$( echo $missing_dep | cut -d/ -f1 )
  package=$( echo $missing_dep | cut -d/ -f2- | cut -d. -f1 | rev | cut -d- -f2- | rev )
  version=$( echo $missing_dep | sed -r 's/.*-([0-9]+.*)$/\1/gm' | cut -d '[' -f1 )
  return 0
}

# download pyproject.toml for given version
# -> version to download
# <- file /tmp/<package>-<version>-pyproject.toml
get_pyproject() {
  [ -s "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml" ] && return 0
  rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml" &> /dev/null
  local github=$( cat metadata.xml | grep "<remote-id type=\"github\">" | cut -d '>' -f2 | cut -d '<' -f1 )
  wget -q "https://raw.githubusercontent.com/${github}/refs/tags/v$1/pyproject.toml" -O "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml"
  [ -s "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml" ] && return 0
  rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml" &> /dev/null
  wget -q "https://raw.githubusercontent.com/${github}/refs/tags/$1/pyproject.toml" -O "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml"
  [ -s "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml" ] && return 0
  rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml" &> /dev/null
  return 1
}

# extract a subpart of pyproject
# -> version of package
# -> category of pyproject to extract
# <- file /tmp/<package>-<version>-pyproject-<category>.toml
extract_category() {
  echo -ne "  extract [$2]..."
  line=$( grep -n "\[$2\]" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml" | cut -d: -f1 )
  tail --lines=+$(( line + 1 )) "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml" | cut -d: -f1 > "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-$2-tmp.toml" | cut -d: -f1 
  line=$( grep -n "^\[" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-$2-tmp.toml" | head -n1 | cut -d: -f1 )
  head --lines=$(( line - 1 )) "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-$2-tmp.toml" > "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-$2.toml"
  rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-$2-tmp.toml" > /dev/null
  [ -s "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-$2.toml" ] && echo -e "\e[1;32mOK\e[0m" && return 0 
  echo -e "\e[1;31mfailed\e[0m" && return 1
}

# Update a given dependenciy version
# -> version of main ebuild
# -> depencies package name (with category)
# -> dependency operator (>=, <=, ~...)
# -> dependency version
update_ebuild() {
  # Get line numer
  local line=$( grep -n "$2-[0-9]" "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" | cut -d: -f1 )
  if [ -z "$line" ]; then
    line=$( grep -n "^RDEPEND=\"$" "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" | cut -d: -f1 )
    [ -z "$line" ] && echo -e "\e[1;31mSKIPPED\e[0m (not found)" && return 1
    # head
    head --line=+$line "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" > "$( pwd | rev | cut -d/ -f1 | rev )-$1-tmp.ebuild"
    echo -e "\t$3$2-$4[\${PYTHON_USEDEP}]" >> "$( pwd | rev | cut -d/ -f1 | rev )-$1-tmp.ebuild"
    tail --line=+$(( line + 1 )) "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" >> "$( pwd | rev | cut -d/ -f1 | rev )-$1-tmp.ebuild"
  else
    # head
    head --line=+$(( line - 1 )) "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" > "$( pwd | rev | cut -d/ -f1 | rev )-$1-tmp.ebuild"
    # update line
    echo -e "\t$3$2-$4[$( tail --line=+$line "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" | head -n1 | cut -d '[' -f2- )" >> "$( pwd | rev | cut -d/ -f1 | rev )-$1-tmp.ebuild"
    # tail
    tail --line=+$(( line + 1 )) "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" >> "$( pwd | rev | cut -d/ -f1 | rev )-$1-tmp.ebuild"
  fi
  mv "$( pwd | rev | cut -d/ -f1 | rev )-$1-tmp.ebuild" "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild"
  echo -e "\e[1;32mOK\e[0m"
  return 0
}

# Update ebuild dependencies version for hatchling ebuild
# -> version of package
# <- write update in .ebuild directly
update_ebuild_hatchling() {
  extract_category "$1" "project" || return 1
  # Extract dependencies 
  if [ -z "$( grep "^dependencies[[:space:]]*=[[:space:]]*\[" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project.toml" )" ]; then
    rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-*.toml" &> /dev/null
    return 0
  fi
  tail --lines=+$( grep -n "^dependencies[[:space:]]*=[[:space:]]*\[" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project.toml" | cut -d ':' -f1 ) "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project.toml" > "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml"
  head --lines=$( grep -n "]$" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" | head -n1 | cut -d: -f1 ) "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" > "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-tmp.toml"
  rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" &> /dev/null
  while read line; do
    echo -n $line >> "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml"
  done < "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-tmp.toml"
  rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-tmp.toml" &> /dev/null
  echo "  Parse dep..."
  for dep in $( cat "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" | cut -d '[' -f2- | rev | cut -d ']' -f2- | rev | sed 's/ //g' | sed 's/","/ /g' | sed 's/"//g' ); do
    local dep_name=""
    local dep_operator=""
    local dep_version=""
    case "$dep" in
      *===*) dep_name=$( echo $dep | cut -d '=' -f1) && dep_operator="~"  && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d '=' -f4- | cut -d ';' -f1 ) ;;
      *\>=*) dep_name=$( echo $dep | cut -d '>' -f1) && dep_operator=">=" && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d '=' -f2- | cut -d ';' -f1 ) ;;
      *\<=*) dep_name=$( echo $dep | cut -d '<' -f1) && dep_operator="<=" && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d '=' -f2- | cut -d ';' -f1 ) ;;
      *==*)  dep_name=$( echo $dep | cut -d '=' -f1) && dep_operator="~"  && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d '=' -f3- | cut -d ';' -f1 ) ;;
      *!=*)  dep_name=$( echo $dep | cut -d '!' -f1) && dep_operator="!"  && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d '=' -f2- | cut -d ';' -f1 ) ;;
      *~=*)  dep_name=$( echo $dep | cut -d '~' -f1) && dep_operator="~"  && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d '=' -f2- | cut -d ';' -f1 ) ;;
      *\>*)  dep_name=$( echo $dep | cut -d '>' -f1) && dep_operator=">=" && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d '>' -f2- | cut -d ';' -f1 ) ;;
      *\<*)  dep_name=$( echo $dep | cut -d '<' -f1) && dep_operator="<=" && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d '<' -f2- | cut -d ';' -f1 ) ;;
      *)  echo -e "    ${dep}...\e[1;31m SKIPPED\e[0m" && continue;;
    esac
    [ -z "${dep_name,,}" || "${dep_name,,}" == "python" ] && echo -e "    ${dep}...\e[1;31m SKIPPED\e[0m" && continue
    if [ -z "$( eix -# dev-python/${dep_name,,} | grep "/${dep_name,,}$" )" ]; then
      dep_name=$( eix -# ${dep_name,,} | grep "/${dep_name,,}$" )
    else
      dep_name=$( eix -# dev-python/${dep_name,,} | grep "/${dep_name,,}$" )
    fi
    echo -n "    ${dep_name} ${dep_operator}${dep_version}..."
    [ -n "$dep_name" ] && update_ebuild "$1" "$dep_name" "$dep_operator" "$dep_version"
  done
  rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-*.toml" &> /dev/null
  return 0
}

# Update ebuild dependencies version for poetry v1 ebuild
# -> version of package
# <- write update in .ebuild directly
update_ebuild_poetry_v1() {
  extract_category "$1" "tool.poetry.dependencies" || return 1
  #Remove new lines within { } version description 
  echo "" > /tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml
  local newline='X'
  while read line; do
    if [ -z "$newline" ]; then
      # } closing description
      echo -n $line >> /tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml
      if [ -n "$( echo $line | sed 's/ //g' | cut -d= -f2- | grep '}$' )" ]; then
        newline='X'
      fi
    elif [ -n "$( echo $line | sed 's/ //g' | cut -d= -f2- | grep '^"' )" ]; then
      # " " version description
      echo $line >> /tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml
    elif [ -n "$( echo $line | sed 's/ //g' | cut -d= -f2- | grep '^{' | grep '}$' )" ]; then
      # { } version descirption on a signle line
      echo $line >> /tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml
    else
      # unclosed { } version description
      echo -n $line >> /tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml
      newline=''
    fi
  done < /tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies.toml
  echo "  Parse dep..."
  while read line; do
    local dep_name=""
    local dep_operator=""
    local dep_version=""
    [ -z "$line" || "$( echo "${line,,}" | cut -d \  -f1)" == "python" ] && continue
    if [ -n "$( eix -# dev-python/$( echo "${line,,}" | cut -d \  -f1) | grep "/$( echo "${line,,}" | cut -d \  -f1)$" )" ]; then
      dep_name=$( eix -# dev-python/$( echo "${line,,}" | cut -d \  -f1) | grep "/$( echo "${line,,}" | cut -d \  -f1)$" )
    else
      dep_name=$( eix -# $( echo "${line,,}" | cut -d \  -f1) | grep "/$( echo "${line,,}" | cut -d \  -f1)$" )
    fi
    [ -z "$dep_name" ] && echo -e "    $( echo "$line" | cut -d \  -f1 )\e[1;31m SKIPPED\e[0m" && continue
    local versionstring=$(echo $line | sed 's/ //g' | cut -d= -f2- )
    if [ -n "$( echo $versionstring | grep '^"' )" ]; then
      versionstring=$(echo "$versionstring" | sed 's/"//g' | cut -d ',' -f1 )
    else
      for subversion in $( echo $versionstring | sed 's/^{//g' | sed 's/}$//g' | sed 's/,/ /g' ); do
	[ "$( echo $subversion | cut -d= -f1 )" == "version" ] && versionstring=$(echo $subversion | cut -d= -f2- | sed 's/"//g' )
      done
    fi
    case "$versionstring" in
      \>=*) dep_operator=">=" && dep_version=$( echo $versionstring | cut -c3- );;
      \<=*) dep_operator="<=" && dep_version=$( echo $versionstring | cut -c3- );;
      !=*) dep_operator="!" && dep_version=$( echo $versionstring | cut -c3- );;
      ==*) dep_operator="~" && dep_version=$( echo $versionstring | cut -c3- );;
      ~*) dep_operator="~" && dep_version=$( echo $versionstring | cut -c2- );;
      ^*) dep_operator="~" && dep_version=$( echo $versionstring | cut -c2- );;
      \>*) dep_operator=">" && dep_version=$( echo $versionstring | cut -c2- );;
      \<*) dep_operator="<" && dep_version=$( echo $versionstring | cut -c2- );;
      *) echo -e "${dep_name}...\e[1;31m SKIPPED\e[0m (can't parse ${versionstring})" && continue;;
    esac
    echo -n "    ${dep_name} ${dep_operator}${dep_version}..."
    update_ebuild "$1" "$dep_name" "$dep_operator" "$dep_version"
  done < /tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml
  rm /tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml > /dev/null
  return 0
}

update_ebuild_setuptools() {
  extract_category "$1" "project" || return 1
  # Extract dependencies 
  if [ -n "$( grep "^dependencies[[:space:]]*=[[:space:]]*\[" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project.toml" )" ]; then
    tail --lines=+$( grep -n "^dependencies[[:space:]]*=[[:space:]]*\[" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project.toml" | cut -d ':' -f1 ) "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project.toml" > "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml"
    head --lines=$( grep -n "]$" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" | head -n1 | cut -d: -f1 ) "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" > "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-tmp.toml"
    rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" &> /dev/null
    while read line; do
      echo -n $line >> "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml"
    done < "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-tmp.toml"
    rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-tmp.toml" &> /dev/null
    echo "  Parse dep..."
    for dep in $( cat "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" | cut -d '[' -f2- | rev | cut -d ']' -f2- | rev | sed 's/ //g' | sed 's/","/ /g' | sed 's/"//g' ); do
      local dep_name=""
      local dep_operator=""
      local dep_version=""
      
      dep_name=$( echo ${dep,,} | cut -d '(' -f1 | cut -d '[' -f1 )
      case "$( echo $dep | cut -d '(' -f2 )" in
        ===*)  dep_operator="~"  && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f4-) ;;
        ==*)   dep_operator="~"  && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f3-) ;;
        \>=*)  dep_operator=">=" && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f2-) ;;
        \<=*)  dep_operator="<=" && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f2-) ;;
        !=*)   dep_operator="!"  && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f2-) ;;
        ~=*)   dep_operator="~"  && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f2-) ;;
        \>*)   dep_operator=">=" && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '>' -f2-) ;;
        \<*)   dep_operator="<=" && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '<' -f2-) ;;
        *===*) dep_operator="~"  && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f4-) && dep_name=$( echo ${dep,,} | cut -d '=' -f1) ;;
        *==*)  dep_operator="~"  && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f3-) && dep_name=$( echo ${dep,,} | cut -d '=' -f1) ;;
        *\>=*) dep_operator=">=" && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f2-) && dep_name=$( echo ${dep,,} | cut -d '>' -f1) ;;
        *\<=*) dep_operator="<=" && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f2-) && dep_name=$( echo ${dep,,} | cut -d '<' -f1) ;;
        *!=*)  dep_operator="!"  && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f2-) && dep_name=$( echo ${dep,,} | cut -d '!' -f1) ;;
        *~=*)  dep_operator="~"  && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f2-) && dep_name=$( echo ${dep,,} | cut -d '~' -f1) ;;
        *\>*)  dep_operator=">=" && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '>' -f2-) && dep_name=$( echo ${dep,,} | cut -d '>' -f1) ;;
        *\<*)  dep_operator="<=" && dep_version=$( echo $dep | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '<' -f2-) && dep_name=$( echo ${dep,,} | cut -d '<' -f1) ;;
	*)  echo -e "    ${dep}...\e[1;31m SKIPPED\e[0m" && continue;;
      esac
      [ -z "${dep_name}" || "${dep_name,,}" == "python" ] && echo -e "    ${dep}...\e[1;31m SKIPPED\e[0m" && continue
      if [ -n "$( eix -# dev-python/${dep_name,,} | grep "/${dep_name,,}$" )" ]; then
        dep_name=$( eix -# dev-python/${dep_name,,} | grep "/${dep_name,,}$" )
      else
        dep_name=$( eix -# ${dep_name,,} | grep "/${dep_name,,}$" | head -n1 )
      fi
      
      echo -n "    ${dep_name} ${dep_operator}${dep_version}..."
      update_ebuild "$1" "$dep_name" "$dep_operator" "$dep_version"
    done
    rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-*.toml" &> /dev/null
    return 0

  fi
}

# Move to root repository
if [ "$(pwd | rev | cut -d/ -f1 | rev)" == "scripts" ]; then
  pushd .. > /dev/null
elif [ "$( echo $0 | rev | cut -d/ -f2- )" == "stpircs/." ]; then
  pushd . > /dev/null
else
  echo "Please run in root repo or script subfolder"
  exit 1
fi

# Get missing dep
while get_missing_dep; do
  [ -z "$package" ] && exit 0
  echo -e "Package \e[1;31m${category}/${package} (${version})\e[0m is missing"
  
  # Move to dep folder
  pushd ${category}/${package} > /dev/null
  
  echo -ne "  create by copy ${package}-${version}.ebuild..."
  if cp $( ls ${package}*.ebuild -rv 2> /dev/null | head -n1 ) ${package}-${version}.ebuild &> /dev/null; then
    echo -e "\e[1;32mOK\e[0m"
  else
    echo -e "\e[1;31mfailed\e[0m"
    exit 2
  fi
  
  echo -ne "  get pyproject.toml..."
  rm "/tmp/${package}-${version}-*.toml" &> /dev/null
  get_pyproject "${version}"
  if [ -n "$( cat "/tmp/${package}-${version}-pyproject.toml" | grep "build-backend = \"poetry.core.masonry.api\"" )" ]; then
    echo -e "\e[1;32mFound poetry\e[0m"
    update_ebuild_poetry_v1 "${version}" || update_ebuild_setuptools "${version}"
  elif [ -n "$( cat "/tmp/${package}-${version}-pyproject.toml" | grep "build-backend = \"hatchling.build\"" )" ]; then
    echo -e "\e[1;32mFound hatchling\e[0m"
    update_ebuild_hatchling "${version}"
  elif [ -n "$( cat "/tmp/${package}-${version}-pyproject.toml" | grep "build-backend = \"setuptools.build_meta\"" )" ]; then
    echo -e "\e[1;32mFound setuptools\e[0m"
    update_ebuild_setuptools "${version}"
  else
    echo -e "\e[1;31mUnrecognized\e[0m"
    exit 3
  fi
  
  echo -n "  check ebuild..."
  if ebuild ${package}-${version}.ebuild digest clean install &> /dev/null; then
    echo -e "\e[1;32mOK\e[0m"
  else
    echo -e "\e[1;31m FAILED\e[0m" 
    exit 4
  fi

  echo -n "  git commit..."
  if git add . &> /dev/null && git commit -m "feature/ deps for app-misc/$( ls ../../app-misc/homeassistant/*.ebuild -vr | head -n1 | rev | cut -d. -f2- | cut -d/ -f1 | rev )" &> /dev/null ; then
    echo -e "\e[1;32mOK\e[0m"
  else
    echo -e "\e[1;31m FAILED\e[0m" 
    exit 5
  fi
  popd > /dev/null
  category=""
  package=""
  version=""
done

popd > /dev/null
