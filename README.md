# OUX/C+ programming language: modules and build environment

[Podręcznik OUX/C+](https://overcq.ct8.pl/podrecznik-oux-c.html)

# Information and instructions to the user

## 1. Contact

Manufacturer: overcq

Contact the manufacturer: overcq@int.pl

Source code: https://github.com/overcq/oux

Description: https://overcq.ct8.pl/oux-c-plus.html

## 2. Vulnerabilities

Report vulnerabilities: https://github.com/overcq/oux/security/advisories or via e‐mail: overcq@int.pl

## 3. Version and development environments

OUX/C+ 3. Detailed version in git log.

The product is developed in Debian (inside Windows Subsystem for Linux) and tested in FreeBSD, NetBSD, OpenBSD.

## 4. Purpose

The product is intended for software development in unix-like systems (also inside Windows Subsystem for Linux).

Parts inside modules:

* memory manager: [mem-blk.cx](https://github.com/overcq/oux/tree/main/module/base/mem-blk.cx)
* memory tables: [mem-tab.cx](https://github.com/overcq/oux/tree/main/module/base/mem-tab.cx)
* read and write files: [mem-file.cx](https://github.com/overcq/oux/tree/main/module/base/mem-file.cx)
* fork exec sequence: [flow-fork.cx](https://github.com/overcq/oux/tree/main/module/base/flow-fork.cx)
* text manipulation routines: [text.cx](https://github.com/overcq/oux/tree/main/module/base/text.cx)
* text parser: [text-syntax.cx](https://github.com/overcq/oux/blob/main/module/base/text-syntax.cx)
* universal user interface: [ui.cx](https://github.com/overcq/oux/blob/main/module/ui/ui.cx)
* graphical user interface: [“gui-wayland” module](https://github.com/overcq/oux/tree/main/module/gui-wayland)
* text user interface: [“tui” module](https://github.com/overcq/oux/tree/main/module/tui)
* big floating-point numbers: [math-bignum.cx](https://github.com/overcq/oux/tree/main/module/base/math-bignum.cx)

and more…

## 5. Risk

Developing software using this product requires developer experience. Good programming practices in C+ should be used.

## 6. Component materials

This product uses external libraries (source code available through the operating systemʼs package system):

* “libc” and related libraries
* “ncurses” unicode
* [OpenSSL](https://www.openssl.org/source/)
* “wayland”

This product has been built using unix-like tools, in particular:

* “apropos”
* “awk”
* “clang” or “gcc”
* “grep”
* “install”
* “libtool”
* GNU “make”
* “man”
* “mktemp”
* “perl”
* “printf”
* “rm”
* shell
* “sleep”
* “sort”
* “uniq”
* “xargs”
* “Xdialog”
* “xterm”

## 7. Support

Technical security support at: https://overcq.ct8.pl/oux-c-plus.html and via e‐mail: overcq@int.pl

Issues at: https://github.com/overcq/oux/issues

Product support continues for the latest git release.

## 8. Installation and update

Fetching for first use can be done with a command, for example `git clone https://github.com/overcq/oux.git`.
To build the project, it is required to have the “man” documentation installed in the operating system.

The user should make regular updates, e.g. with a command `git pull && make`, then as “root”: `make install`. Then follow the appropriate update and installation instructions for the products that depend on the current one.
Before using this commands can be executed as “root”: `make uninstall` and/or as the user: `make clean`, to remove any remaining intermediate files that depend on source files that have been removed in the new product version.

To completely remove the product from the userʼs device, execute, for example, as “root”: `make uninstall`, then as the user: `rm -fr oux`.

# Other Licenses

This product includes software developed by the OpenSSL Project for use in the OpenSSL Toolkit (http://www.openssl.org/)
