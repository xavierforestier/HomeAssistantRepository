echo "Delete orphan packages..."
for pkg in ` pkgcheck scan -k RedundantVersion | cut -d\  -f1 | grep .`
do
  if grep -rn $pkg app-misc/homeassistant > /dev/null
  then
    echo -en "\r                                 \r$pkg..."
    cat=`echo $pkg | cut -d/ -f1`
    name=`echo $pkg | cut -d/ -f2`
    for inst in `ls $pkg/*.ebuild`
    do
      version=`echo $inst | rev | cut -d. -f2- | rev | cut -d/ -f3-`
      if [ -z "$( grep -rn $cat/$version app-misc/homeassistant)" ] && [ -z "$( grep -rn $cat/$version dev-embedded/esphome)" ]; then
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
#egencache --repo=HomeAssistantRepository --sign-manifests=n --update --update-changelogs --update-pkg-desc-index --update-use-local-desc --update-manifests
egencache --repo=HomeAssistantRepository --sign-manifests=n --update --update-changelogs --update-pkg-desc-index --update-manifests
