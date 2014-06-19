#!/bin/sh
set -e
DIR="$(cd "$(dirname "${0}")" && pwd)"

PACKAGE='gearmand'
DIR_PACKAGE="${DIR}/packages/${PACKAGE}"
VERSION=$(cat "${DIR_PACKAGE}/version" | xargs)
URL=$(cat "${DIR_PACKAGE}/url" | xargs)

cd "${DIR_PACKAGE}"
rm -rf tmp/ && mkdir tmp/ && cd tmp/
wget "${URL}"
unp ${PACKAGE}-${VERSION}.tar.gz
mv ${PACKAGE}-${VERSION}.tar.gz ${PACKAGE}_${VERSION}.orig.tar.gz
cd ${PACKAGE}-${VERSION}/

cp -r ../../debian ./debian
mk-build-deps --install --remove debian/control
dpkg-buildpackage -us -uc

cd "${DIR_PACKAGE}"
rm -rf pkg/ && mkdir pkg/
mv tmp/*.deb pkg/
rm -rf tmp/

DEB_LIST=$(perl -lne '/^Package: (.+)$/ && print $1' "${DIR_PACKAGE}/debian/control")
for DEB in ${DEB_LIST}; do
  echo
  echo "Adding ${DEB} to repo..."
  if (reprepro -b "${DIR}/repo" list wheezy "${DEB}" | grep -q "${DEB}"); then
    reprepro -b "${DIR}/repo" remove wheezy "${DEB}"
  fi
  reprepro -b "${DIR}/repo" includedeb wheezy "${DIR_PACKAGE}/pkg/${DEB}_"*.deb
done
