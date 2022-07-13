# Architecture

* x86_64
* x86

# Testing systems

* Gentoo Linux

Software development operating system.

* FreeBSD 13.1

It starts.
![FreeBSD](pictures/FreeBSD.png)

* OpenBSD 7.1

There is an error starting up.

# Requirements

The compilation system should include:
* utility programs
* clang or gcc
* "man" documentation for system functions and the libraries below
* OpenSSL
* xcb

To run the test program ("make run") should be installed:
* modified [urxvt](https://github.com/overcq/rxvt-unicode), possibly xterm

# Compilation and installation

Below is a reference to a program ‟GNU make”, which can be run using the command “gmake”.

Should do:
1. as a regular user: “make” and confirm that you agree to the terms of use
2. as user "root": "make install"

# Building programs dependent on this environment

The directory "oux" should be in any directory parent of the dependent program directory, except the directory "/".

Then you can execute "make" in the directory of the program dependent on this environment.
