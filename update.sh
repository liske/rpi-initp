#!/bin/sh

# rpi-initp - init partition (not only for Raspberry Pi)
#
# Authors:
#   Thomas Liske <thomas@fiasko-nw.net>
#
# Copyright Holder:
#   2013 (C) Thomas Liske [http://fiasko-nw.net/~thomas/]
#
# License:
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this package; if not, write to the Free Software
#   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
#

set -e

mpinitp="$(stat -c %m $0)"
mprootp=$(readlink -f $mpinitp/..)

echo "Mount $mpinitp rw..."
mount "$mpinitp" -o remount,rw


echo "Create basic directories..."

for d in bin dev sys proc tmp sbin target; do
    [ -d "$mpinitp/$d" ] || mkdir -pv "$mpinitp/$d"
done


echo "Copy busybox..."
cp -f "$mprootp/bin/busybox" "$mpinitp/bin/"


echo "Update busybox symlinks..."
for l in $(busybox --list); do
    if [ ! -L "$mpinitp/bin/$l" ]; then
        echo " $l => busybox"
        rm -f "$mpinitp/bin/$l"
        ln -s "busybox" "$mpinitp/bin/$l"
    fi
done


if [ ! -L "$mpinitp/sbin/init" ]; then
    echo "Creating backup busybox init symlink..."
    rm -f "$mpinitp/sbin/init"
    ln -s "/bin/busybox" "$mpinitp/sbin/init"
fi

echo "Checking rpi-initp files:"

for fn in "$mpinitp/sbin/pinit" "$mpinitp/sbin/sinit" "$mprootp/lib/init/pinit-stub"; do
    echo -n " $fn: "; [ -x "$fn" ] && echo "OK" || echo "FAILED"
done
