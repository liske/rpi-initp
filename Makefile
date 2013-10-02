prefix=$(stat -c %m .)

all: sinit blkid

sinit: sinit.c
	gcc -Wall -static sinit.c -o sinit

blkid: busybox/_install/bin/busybox
	cp busybox/_install/bin/busybox blkid

busybox/_install/bin/busybox: busybox/.config
	cd busybox && make install

busybox/.config: blkid.config
	cp blkid.config busybox/.config

clean:
	rm -f sinit blkid
	cd busybox && make clean

install: sinit blkid
	cp pinit-stub "${prefix}/lib/init/"
	cp update.sh "${prefix}/initp/"
	mkdir -p "${prefix}/initp/sbin"
	cp pinit "${prefix}/initp/sbin"
	cp sinit "${prefix}/initp/sbin/"
	cp blkid "${prefix}/initp/bin"
