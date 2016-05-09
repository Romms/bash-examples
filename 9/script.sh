#!/bin/bash

wget http://mirror.yandex.ru/gentoo-distfiles/releases/amd64/autobuilds/latest-stage3.txt

lastd=/`egrep -ro [0-9]+/stage3-amd64-[0-9]+.tar.bz2 latest-stage3.txt`
paket=`egrep -ro stage3-amd64-[0-9]+.tar.bz2 latest-stage3.txt`

echo $lastd

wget http://mirror.yandex.ru/gentoo-distfiles/releases/amd64/autobuilds${lastd}
tar xf $paket -C /media