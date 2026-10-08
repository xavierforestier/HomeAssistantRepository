#!/bin/bash

######
# Author: Xavier FORESTIER
# Source: https://github.com/xavierforestier/HomeAssistantRepository
# Purpose: With the given package in parameter try to auto-generate all missing dependcies
# Status: Very early alpha stage :D
#   poetry    : alpha (TODO : [] deps, multiple coma separated version)
#   hatchling : alpha (TODO : [] deps, multiple coma separated version)
#   setuptools: partial
#     pyproject.toml : beta
#     other : TODO (need to handle setup.py, setup.cfg, and try to find most common requirement.txt path)
#   other (uv-build / 
######


category=""
package=""
version=""
commit_message=""
git_repo=""
git_tag=""

# Guess tag matching our version, and download pyproject
# -> version to search for
# <- $git_repo : Github URL
# <= $git_tag : Github tagname
get_tagname() {  
  git_tag=""
  git_repo="$( cat metadata.xml | grep "<remote-id type=\"github\">" | cut -d '>' -f2 | cut -d '<' -f1 )"
  [ -n "$git_repo" ] && git_tag=$( curl -s -L -H "Accept: application/vnd.github+json" https://api.github.com/repos/${git_repo}/tags | jq -r ".[] | select(.name == \"v$1\").name" )
  [ -z "$git_tag" ] && git_tag=$( curl -s -L -H "Accept: application/vnd.github+json" https://api.github.com/repos/${git_repo}/tags | jq -r ".[] | select(.name == \"V$1\").name" )
  [ -z "$git_tag" ] && git_tag=$( curl -s -L -H "Accept: application/vnd.github+json" https://api.github.com/repos/${git_repo}/tags | jq -r ".[] | select(.name == \"$1\").name" )
  [ -n "$git_repo" ] && [ -n "$git_tag" ] && return 0
  return 1
}

# Download pyproject.toml for given version
# -> version to download
# <- file /tmp/<package>-<version>-pyproject.toml
get_pyproject() {
  rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml" &> /dev/null
  wget -q "https://raw.githubusercontent.com/${git_repo}/refs/tags/${git_tag}/pyproject.toml" -O "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml"
  [ -s "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml" ] && return 0
  rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml" &> /dev/null
  return 1
}

# extract a subpart of pyproject
# -> version of package
# -> category of pyproject to extract
# <- file /tmp/<package>-<version>-pyproject-<category>.toml
extract_category() {
  echo -ne " \e[0;32m*\e[0m Extract [$2]..."
  line=$( grep -n "\[$2\]" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml" | cut -d: -f1 )
  tail --lines=+"$(( line + 1 ))" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject.toml" > "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-$2-tmp.toml" 
  line=$( grep -n "^\[" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-$2-tmp.toml" | head -n1 | cut -d: -f1 )
  head --lines="$(( line - 1 ))" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-$2-tmp.toml" > "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-$2.toml"
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
  local line
  line=$( grep -n "$2-[0-9]" "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" | cut -d: -f1 )
  if [ -z "$line" ]; then
    line=$( grep -n "^RDEPEND=\"$" "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" | cut -d: -f1 )
    if [ -z "$line" ]; then
      echo -e "\e[1;31mERROR\e[0m (ebuild error RDEPEND missing)"
      commit_msg="${commit_msg}-$2 Ebuild ERROR"
      return 1
    fi
    # head
    head --line=+"${line}" "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" > "$( pwd | rev | cut -d/ -f1 | rev )-$1-tmp.ebuild"
    echo -e "\t$3$2-$4[\${PYTHON_USEDEP}]" >> "$( pwd | rev | cut -d/ -f1 | rev )-$1-tmp.ebuild"
    commit_msg="${commit_msg}-$2 added\n\`\`\`diff\n+\t+$3$2-$4[\${PYTHON_USEDEP}]\`\`\`"
    tail --line=+"$(( line + 1 ))" "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" >> "$( pwd | rev | cut -d/ -f1 | rev )-$1-tmp.ebuild"
  else
    # head
    head --line=+"$(( line - 1 ))" "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" > "$( pwd | rev | cut -d/ -f1 | rev )-$1-tmp.ebuild"
    # update line
    echo -e "\t$3$2-$4[$( tail --line=+"${line}" "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" | head -n1 | cut -d '[' -f2- )" >> "$( pwd | rev | cut -d/ -f1 | rev )-$1-tmp.ebuild"
    commit_msg="${commit_msg}-$2 updated\n\`\`\`diff\n-\t$( tail --line=+"${line}" "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" | head -n1 )\n+\t+$3$2-$4[\${PYTHON_USEDEP}]\`\`\`"
    # tail
    tail --line=+"$(( line + 1 ))" "$( pwd | rev | cut -d/ -f1 | rev )-$1.ebuild" >> "$( pwd | rev | cut -d/ -f1 | rev )-$1-tmp.ebuild"
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
  if ! grep -q "^dependencies[[:space:]]*=[[:space:]]*\[" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project.toml"; then
    rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-*.toml" &> /dev/null
    return 0
  fi
  tail --lines=+"$( grep -n "^dependencies[[:space:]]*=[[:space:]]*\[" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project.toml" | cut -d ':' -f1 )" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project.toml" > "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml"
  head --lines="$( grep -n "]$" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" | head -n1 | cut -d: -f1 )" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" > "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-tmp.toml"
  rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" &> /dev/null
  while read -r line; do
    if ! echo "$line" | grep -q "^[[:space:]]*#.*$"; then
      echo -n "$line" >> "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml"
    fi
  done < "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-tmp.toml"
  rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-tmp.toml" &> /dev/null
  echo -e " \e[0;32m*\e[0m Parse dependencies..."
  for dep in $( cat "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" | cut -d '[' -f2- | rev | cut -d ']' -f2- | rev | sed 's/ //g' | sed 's/","/ /g' | sed 's/"//g' ); do
    local dep_name=""
    local dep_operator=""
    local dep_version=""
    case "$dep" in
      *===*) dep_name=$( echo "$dep" | cut -d '=' -f1) && dep_operator="~"  && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d '=' -f4- | cut -d ';' -f1 ) ;;
      *\>=*) dep_name=$( echo "$dep" | cut -d '>' -f1) && dep_operator=">=" && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d '=' -f2- | cut -d ';' -f1 ) ;;
      *\<=*) dep_name=$( echo "$dep" | cut -d '<' -f1) && dep_operator="<=" && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d '=' -f2- | cut -d ';' -f1 ) ;;
      *==*)  dep_name=$( echo "$dep" | cut -d '=' -f1) && dep_operator="~"  && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d '=' -f3- | cut -d ';' -f1 ) ;;
      *!=*)  dep_name=$( echo "$dep" | cut -d '!' -f1) && dep_operator="!"  && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d '=' -f2- | cut -d ';' -f1 ) ;;
      *~=*)  dep_name=$( echo "$dep" | cut -d '~' -f1) && dep_operator="~"  && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d '=' -f2- | cut -d ';' -f1 ) ;;
      *\>*)  dep_name=$( echo "$dep" | cut -d '>' -f1) && dep_operator=">=" && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d '>' -f2- | cut -d ';' -f1 ) ;;
      *\<*)  dep_name=$( echo "$dep" | cut -d '<' -f1) && dep_operator="<=" && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d '<' -f2- | cut -d ';' -f1 ) ;;
      *)  echo -e "    ${dep}...\e[1;31m SKIPPED\e[0m" && continue;;
    esac
    if [ -z "${dep_name,,}" ] || [ "${dep_name,,}" == "python" ]; then
      echo -e "    ${dep}...\e[1;31m SKIPPED\e[0m" && continue
    elif ! eix -# "dev-python/${dep_name,,}" | grep -q "/${dep_name,,}$"; then
      dep_name=$( eix -# "${dep_name,,}" | grep "/${dep_name,,}$" )
    else
      dep_name=$( eix -# "dev-python/${dep_name,,}" | grep "/${dep_name,,}$" )
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
  echo "" > "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml"
  local newline='X'
  while read -r line; do
    if [ -z "$newline" ]; then
      # } closing description
      echo -n "$line" >> "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml"
      if echo "$line" | sed 's/ //g' | cut -d= -f2- | grep -q '}$'; then
        newline='X'
      fi
    elif echo "$line" | sed 's/ //g' | cut -d= -f2- | grep -q '^"'; then
      # " " version description
      echo "$line" >> "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml"
    elif echo "$line" | sed 's/ //g' | cut -d= -f2- | grep '^{' | grep -q '}$'; then
      # { } version descirption on a signle line
      echo "$line" >> "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml"
    else
      # unclosed { } version description
      echo -n "$line" >> "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml"
      newline=''
    fi
  done < "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies.toml"
  echo -e " \e[0;32m*\e[0m  Parse dependencies..."
  if [ -s "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml" ]; then
    echo -e " \e[0;32m*\e[0m  Parse dependencies..."
    commit_msg="${commit_msg}\nDependencies found (poetry v1):"
  else
    echo -e " \e[0;32m*\e[0m  No dependency"
    commit_msg="${commit_msg}\nno dependency found"
  fi
  while read -r line; do
    local dep_name=""
    local dep_operator=""
    local dep_version=""
    if [ -z "$line" ] || [ "$( echo "${line,,}" | cut -d \  -f1)" == "python" ]; then
      continue
    fi
    if eix -# "dev-python/$( echo "${line,,}" | cut -d \  -f1)" | grep -q "/$( echo "${line,,}" | cut -d \  -f1)$"; then
      dep_name=$( eix -# "dev-python/$( echo "${line,,}" | cut -d \  -f1)" | grep "/$( echo "${line,,}" | cut -d \  -f1)$" )
    else
      dep_name=$( eix -# "$( echo "${line,,}" | cut -d \  -f1)" | grep "/$( echo "${line,,}" | cut -d \  -f1)$" )
    fi
    if [ -z "$dep_name" ]; then      
      echo -e "    $( echo "$line" | cut -d \  -f1 )\e[1;31m SKIPPED\e[0m (no ebuild found)"
      commit_msg="${commit_msg}\n- dependency skipped: $line (no ebuild found)"
      continue
    fi
    local versionstring
    versionstring="$(echo "$line" | sed 's/ //g' | cut -d= -f2- )"
    if echo "$versionstring" | grep -q '^"'; then
      versionstring=$(echo "$versionstring" | sed 's/"//g' | cut -d ',' -f1 )
    else
      for subversion in $( echo "$versionstring" | sed 's/^{//g' | sed 's/}$//g' | sed 's/,/ /g' ); do
	[ "$( echo "$subversion" | cut -d= -f1 )" == "version" ] && versionstring=$(echo "$subversion" | cut -d= -f2- | sed 's/"//g' )
      done
    fi
    case "$versionstring" in
      \>=*) dep_operator=">=" && dep_version=$( echo "$versionstring" | cut -c3- );;
      \<=*) dep_operator="<=" && dep_version=$( echo "$versionstring" | cut -c3- );;
      !=*)  dep_operator="!"  && dep_version=$( echo "$versionstring" | cut -c3- );;
      ==*)  dep_operator="~"  && dep_version=$( echo "$versionstring" | cut -c3- );;
      ~*)   dep_operator="~"  && dep_version=$( echo "$versionstring" | cut -c2- );;
      ^*)   dep_operator="~"  && dep_version=$( echo "$versionstring" | cut -c2- );;
      \>*)  dep_operator=">"  && dep_version=$( echo "$versionstring" | cut -c2- );;
      \<*)  dep_operator="<"  && dep_version=$( echo "$versionstring" | cut -c2- );;
      *) 
        echo -e "${dep_name}...\e[1;31m SKIPPED\e[0m (can't parse ${versionstring})" 
	commit_msg="${commit_msg}\n- dependency skipped $line (parse error)"
	return 1
	;;
    esac
    echo -n "    ${dep_name} ${dep_operator}${dep_version}..."
    update_ebuild "$1" "$dep_name" "$dep_operator" "$dep_version"
  done < "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml"
  rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-tool.poetry.dependencies-tmp.toml" > /dev/null
  return 0
}

update_ebuild_setuptools() {
  extract_category "$1" "project" || return 1
  # Extract dependencies 
  if grep -q "^dependencies[[:space:]]*=[[:space:]]*\[" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project.toml"; then
    tail --lines=+"$( grep -n "^dependencies[[:space:]]*=[[:space:]]*\[" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project.toml" | cut -d ':' -f1 )" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project.toml" > "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml"
    head --lines="$( grep -n "]$" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" | head -n1 | cut -d: -f1 )" "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" > "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-tmp.toml"
    rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" &> /dev/null
    while read -r line; do
      if ! echo "$line" | grep -q "^[[:space:]]*#.*$"; then
        echo -n "$line" >> "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml"
      fi
    done < "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-tmp.toml"
    rm "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-tmp.toml" &> /dev/null
    if [ -s "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" ]; then
      echo -e " \e[0;32m*\e[0m Parse dependencies..."
      commit_msg="${commit_msg}Dependencies found (in [project] dependencies):"
    else
      echo -e " \e[0;32m*\e[0m  No dependency"
      commit_msg="${commit_msg}\nERROR no dependency found"
      return 1
    fi
    for dep in $( cat "/tmp/$( pwd | rev | cut -d/ -f1 | rev )-$1-pyproject-project-dependencies.toml" | cut -d '[' -f2- | rev | cut -d ']' -f2- | rev | sed 's/ //g' | sed "s/'/\"/g" | sed 's/","/ /g' | sed 's/"//g' ); do
      local dep_name=""
      local dep_operator=""
      local dep_version=""
      
      dep_name=$( echo "${dep,,}" | cut -d '(' -f1 | cut -d '[' -f1 )
      case "$( echo "$dep" | cut -d '(' -f2 | cut -d ';' -f1 )" in
        ===*)  dep_operator="~"  && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f4-) ;;
        \>=*)  dep_operator=">=" && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f2-) ;;
        \<=*)  dep_operator="<=" && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f2-) ;;
        !=*)   dep_operator="!"  && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f2-) ;;
        ~=*)   dep_operator="~"  && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f2-) ;;
        \>*)   dep_operator=">=" && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '>' -f2-) ;;
        \<*)   dep_operator="<=" && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '<' -f2-) ;;
        ==*)   dep_operator="~"  && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d '=' -f3-) ;;
        *===*) dep_operator="~"  && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d ';' -f1 | cut -d '=' -f4-) && dep_name=$( echo "${dep,,}" | cut -d '=' -f1) ;;
        *\>=*) dep_operator=">=" && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d ';' -f1 | cut -d '=' -f2-) && dep_name=$( echo "${dep,,}" | cut -d '>' -f1) ;;
        *\<=*) dep_operator="<=" && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d ';' -f1 | cut -d '=' -f2-) && dep_name=$( echo "${dep,,}" | cut -d '<' -f1) ;;
        *!=*)  dep_operator="!"  && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d ';' -f1 | cut -d '=' -f2-) && dep_name=$( echo "${dep,,}" | cut -d '!' -f1) ;;
        *~=*)  dep_operator="~"  && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d ';' -f1 | cut -d '=' -f2-) && dep_name=$( echo "${dep,,}" | cut -d '~' -f1) ;;
        *\>*)  dep_operator=">=" && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d ';' -f1 | cut -d '>' -f2-) && dep_name=$( echo "${dep,,}" | cut -d '>' -f1) ;;
        *\<*)  dep_operator="<=" && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d ';' -f1 | cut -d '<' -f2-) && dep_name=$( echo "${dep,,}" | cut -d '<' -f1) ;;
        *==*)  dep_operator="~"  && dep_version=$( echo "$dep" | cut -d ',' -f1 | cut -d ')' -f1 | cut -d ';' -f1 | cut -d '=' -f3-) && dep_name=$( echo "${dep,,}" | cut -d '=' -f1) ;;
	*)  
          echo -e "    ${dep}...\e[1;31m SKIPPED\e[0m (can't parse)"
          commit_msg="${commit_msg}\n- dependency skipped $dep (can't error)"
          return 1
	  ;;
      esac
      # We never depend on python
      [ "${dep_name,,}" == "python" ] && continue
      if [ -z "${dep_name}" ]; then
        echo -e "    ${dep}...\e[1;31m SKIPPED\e[0m (can't parse)"
        commit_msg="${commit_msg}\n- dependency skipped $dep (can't error)"
        return 1
      fi
      if eix -# "dev-python/${dep_name,,}" | grep -q "/${dep_name,,}$"; then
        dep_name=$( eix -# "dev-python/${dep_name,,}" | grep "/${dep_name,,}$" )
      else
        dep_name=$( eix -# "${dep_name,,}" | grep "/${dep_name,,}$" | head -n1 )
      fi
      if [ -z "${dep_name}" ]; then
        echo -e "    $dep\e[1;31m SKIPPED\e[0m (no ebuild found)"
        commit_msg="${commit_msg}\n- dependency skipped $dep (no ebuild found)"
        continue
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
elif [ "$( echo "$0" | rev | cut -d/ -f2- )" == "stpircs/." ]; then
  pushd . > /dev/null
else
  echo "Please run in root repo or script subfolder"
  exit 1
fi

# Check usage

########
if [ $# -eq 2 ] && [ "$2" == "build" ]; then
########

  category="$(echo "$1" | cut -d/ -f1)"
  package="$(echo "$1" | cut -d/ -f2)"
  if [ ! -d "${category}/${package}" ]; then
    echo "$1 is not a valid package"
    popd > /dev/null || exit
    exit 1
  fi
  
  emerge_result=$( emerge -pq ="$category/$( find "$category/$package" | grep "\.ebuild$" | sort -rV | head -n1 | rev | cut -d. -f2- | cut -d/ -f1 | rev )" 2>&1 >/dev/null )
  if [ -z "${emerge_result}" ]; then
    popd > /dev/null || exit
    exit 0
  fi
  missing_dep=$( echo "${emerge_result}" | grep "emerge: there are no ebuilds to satisfy" | cut -d \" -f 2 | sed 's/^[^a-z]*//' )
  if [ -n "${missing_dep}" ]; then
    popd > /dev/null || exit
    $0 "$( echo "$missing_dep" | cut -d/ -f1 )/$( echo "$missing_dep" | cut -d/ -f2- | cut -d. -f1 | rev | cut -d- -f2- | rev )" upgrade "$( echo "$missing_dep" | sed -r 's/.*-([0-9]+.*)$/\1/gm' | cut -d '[' -f1 )"
    exit $( $0 "$1" "$2" )
  else
    popd > /dev/null || exit
    exit 0
  fi

########
elif [ $# -eq 3 ] && [ "$2" == "upgrade" ]; then
########

  category="$(echo "$1" | cut -d/ -f1)"
  package="$(echo "$1" | cut -d/ -f2)"
  version="$3"
  commit_msg="feature/${category}/${package} ${version}(autogenerated)"

  if [ ! -d "${category}/${package}" ] > /dev/null; then
    echo "$1 is not a valid package"
    popd > /dev/null || exit
    exit 1
  fi
  
  # Move to dep folder
  pushd "${category}/${package}" > /dev/null || exit
  
  #Copy ebuild
  echo -ne " \e[0;32m*\e[0m Create by copy ${package}-${version}.ebuild..."
  if cp "$( find . | grep "${package}-.*.ebuild" | sort -rV | head -n1 )" "${package}-${version}.ebuild" &> /dev/null; then
    echo -e "\e[1;32mOK\e[0m"
  else
    echo -e "\e[1;31mfailed\e[0m"
    popd > /dev/null || exit
    exit 2
  fi
  
  # Get pyproject and build
  echo -ne " \e[0;32m*\e[0m Get github tag..."
  if get_tagname "${version}"; then
    echo -e "\e[1;32mOK\e[0m"
    commit_msg="${commit_msg}\nsource repo: ${git_repo}[${git_tag}]"
  else
    echo -e "\e[1;31mfailed\e[0m"
    popd > /dev/null || exit
    exit 3
  fi

  echo -ne " \e[0;32m*\e[0m Get pyproject.toml..."
  rm "/tmp/${package}-${version}-*.toml" &> /dev/null
  if get_pyproject "${version}"; then
    if cat "/tmp/${package}-${version}-pyproject.toml" | grep -q "build-backend = \"poetry.core.masonry.api\""; then
      echo -e "\e[1;32mOK\e[0m (Found \e[1;34mpoetry\e[0m)"
      update_ebuild_poetry_v1 "${version}" || update_ebuild_setuptools "${version}"
    elif cat "/tmp/${package}-${version}-pyproject.toml" | grep -q "build-backend = \"hatchling.build\""; then
      echo -e "\e[1;32mOK \e[0m (Found \e[1;34mhatchling\e[0m)"
      update_ebuild_hatchling "${version}"
    elif cat "/tmp/${package}-${version}-pyproject.toml" | grep -q "build-backend = \"uv_build\""; then
      echo -e "\e[1;32mOK \e[0m (Found \e[1;34muv-build\e[0m)"
      update_ebuild_hatchling "${version}"
    elif cat "/tmp/${package}-${version}-pyproject.toml" | grep -q "build-backend = \"setuptools.build_meta\""; then
      echo -e "\e[1;32mOK\e[0m (Found \e[1;34msetuptools\e[0m)"
      update_ebuild_setuptools "${version}"
    else
      echo -e "\e[1;31mUnrecognized\e[0m"
      popd > /dev/null || exit
      exit 4
    fi
  else
    echo -e "\e[1;31mNot found\e[0m"
    popd > /dev/null || exit
    exit 4
  fi
  
  #Test ebuild
  echo -ne " \e[0;32m*\e[0m Check ebuild..."
  if ebuild "${package}-${version}.ebuild" digest clean install &> /dev/null; then
    echo -e "\e[1;32mOK\e[0m"
    commit_msg="${commit_msg}\nebuild is valid"
  else
    echo -e "\e[1;31m FAILED\e[0m" 
    popd > /dev/null || exit
    exit 5  
  fi
  echo -en " \e[0;32m*\e[0m Git commit..."
  if git add . &> /dev/null; then
    git commit -m "${commit_msg}" &> /dev/null
    echo -e "\e[1;32mOK\e[0m"
  else
    echo -e "\e[1;31m FAILED\e[0m" 
    popd > /dev/null || exit
    exit 6
  fi

  # Recursively check subdependencies
  popd > /dev/null || exit
  if $0 "${category}/${package}" build; then
    exit 0
  else 
    exit 7
  fi

#######
else
#######

  echo -e "\e[1;34mUsage:\e[0;35m\n\n$( echo "$0" | rev | cut -d/ -f1 | rev) <category>/<package> build\e[0m\nTry to build latest available version of the given package, and if dependencies are missing try to autogenerate it\n\n\e[0;35m$( echo "$0" | rev | cut -d/ -f1 | rev) <category>/<package> upgrade <version>\e[0m\nAutotgenerate a new version <category>/<ebuild> based on existing version"
  popd > /dev/null || exit
  exit 1

fi
