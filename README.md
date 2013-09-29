rpi-initp
=========

This project contains some scripts and a very simple init implementation. Using
all together enables to use a _init partition_. _init partition_ is just like a
_init ram disk_ but lives on a block devices.

The project is a workaround for platforms like the _Raspberry Pi_ which are not
supplied with initrd enabled kernels by default nor having a boot loader with
initrd support.

See also a small walk through on using this stuff at https://fiasko-nw.net/~thomas/projects/rpi/usb-rootfs.html
