/* rpi-initp - init partition (not only for Raspberry Pi)
 *
 * Authors:
 *   Thomas Liske <thomas@fiasko-nw.net>
 *
 * Copyright Holder:
 *   2013 (C) Thomas Liske [http://fiasko-nw.net/~thomas/]
 *
 * License:
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this package; if not, write to the Free Software
 *   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
 */

#include <unistd.h>
#include <stdio.h>

#define BUSYBOX	("/bin/busybox")
#define SHELL	("/bin/sh")
#define PINIT	("/sbin/pinit")

int main(const int argc, const char * const argv[], char * const envp[]) {
    char *a[3];

    /* try to run the init shell script */
    a[0] = SHELL;
    a[1] = PINIT;
    a[2] = NULL;
    execve(BUSYBOX, a, envp); \
    perror(BUSYBOX);

    /* failed, try busybox shell */
    a[1] = SHELL;
    execve(BUSYBOX, a, envp); \
    perror(BUSYBOX);

    /* even failed, try a default shell */
    a[0] = SHELL;
    execve(SHELL, a, envp); \
    perror(SHELL);

    /* last resort: kernel panic */
    return 1;
}
