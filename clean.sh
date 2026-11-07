#!/bin/bash
echo "Delete orphan packages..."
for pkg in $( pkgcheck scan -k RedundantVersion | cut -d\  -f1 | grep . )
do
  if grep -rn "$pkg" app-misc/homeassistant > /dev/null
  then
    echo -en "\r                                 \r$pkg..."
    cat=$( echo "$pkg" | cut -d/ -f1 ) 
    for inst in "$pkg"/*.ebuild
    do
      version=$( echo "$inst" | rev | cut -d. -f2- | rev | cut -d/ -f3- )
      if ! grep -qrn "$cat/$version" app-misc/homeassistant && ! grep -qrn "$cat/$version" dev-embedded/esphome; then
        echo "$inst à supprimer"
	rm "$inst"
	find "$pkg" -name '*.ebuild'  -exec ebuild {} digest clean \;
      fi
    done
  fi
done
echo "eclean distfiles"
eclean distfiles
echo "eclean packages"
eclean packages
echo "egencache"
egencache --repo=HomeAssistantRepository --sign-manifests=n --update --update-changelogs --update-pkg-desc-index --update-manifests
