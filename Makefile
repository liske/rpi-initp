prefix=$(stat -c %m .)

sinit: sinit.c
	gcc -Wall -static sinit.c -o sinit

clean:
	rm -f sinit

install: sinit
	cp pinit-stub "${prefix}/lib/init/"
	cp update.sh "${prefix}/initp/"
	mkdir -p "${prefix}/initp/sbin"
	cp sinit "${prefix}/initp/sbin/"
