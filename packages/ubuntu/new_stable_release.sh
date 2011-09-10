#!/bin/bash
set -e
set -u
cd $(dirname ${0})
BASE=${PWD}
REV=${1}
if [ x${2} = x ] ; then
	PPA_REV=1
else
	PPA_REV=${2}
fi

REMOTE="http://packages.springrts.com/builds/"
#REMOTE="http://springlobby.info/temp/" #for testing 

cd /tmp

[ -d evolutionrts-data_${REV} ]  || mkdir evolutionrts-data_${REV}
cd evolutionrts-data_${REV}
wget -N ${REMOTE}/evo-v${REV}.sdz 
mv evo-v${REV}.sdz evolution_rts-stable.sdz
cd ..
tar zfc evolutionrts-data_${REV}.orig.tar.gz evolutionrts-data_${REV}
cd evolutionrts-data_${REV} 
cp -r ${BASE}/evolutionrts-data/debian .
dch -v ${REV}-ppa${PPA_REV}
debuild -S -sa
cp debian/changelog ${BASE}/evolutionrts-data/debian
cd ..
echo cd /tmp && dput ppa:evorts/stable evolutionrts-data_${REV}-ppa${PPA_REV}_source.changes
