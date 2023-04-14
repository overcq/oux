# Information and instructions to the user

## 1.

OUX/C+ programming language: modules and build environment

Contact the manufacturer: ocq@tutanota.com

## 2.

Report vulnerabilities: https://github.com/overcq/oux/security/advisories or via e‐mail: ocq@tutanota.com

## 3.

OUX/C+ 2 (git version)

## 4.

The product is intended for software development in 'unix' systems.

Parts inside modules:

* text manipulation routines: [text.cx](https://github.com/overcq/oux/tree/main/module/base/text.cx)
* fork exec sequence: [flow-fork.cx](https://github.com/overcq/oux/tree/main/module/base/flow-fork.cx)
* text parser: [text-syntax.cx](https://github.com/overcq/oux/blob/main/module/base/text-syntax.cx)
* memory manager: [mem-blk.cx](https://github.com/overcq/oux/tree/main/module/base/mem-blk.cx)
* memory tables: [mem-tab.cx](https://github.com/overcq/oux/tree/main/module/base/mem-tab.cx)
* big floating-point numbers: [math-bignum.cx](https://github.com/overcq/oux/tree/main/module/base/math-bignum.cx)
* read and write files: [mem-file.cx](https://github.com/overcq/oux/tree/main/module/base/mem-file.cx)
* universal user interface: [“ui” module](https://github.com/overcq/oux/tree/main/module/ui)

and much more...

## 5.

Developing software using this product requires developer experience.

## 6.

The product is available at: https://github.com/overcq/oux

OpenSSL dependency is available at: https://www.openssl.org/source/

## 7.

No the EU declaration of conformity.

## 8.

Technical security support at: https://overcq.ct8.pl/oux-c-plus.html and via e‐mail: ocq@tutanota.com

Issues at: https://github.com/overcq/oux/issues

Product support continues for the latest git release.

## 9.

Fetching for first use can be done with a command, for example `git clone git@github.com:overcq/oux.git`.
To build the project, it is required to have the “man” documentation installed in the operating system.

The user should make regular updates, e.g. with a command `git pull`.
Before using this command can be executed `make clean`, to remove any remaining intermediate files that depend on source files that have been removed in the new product version.

Security updates can be installed after updating the product by executing the commands `make; su; make install`. Then follow the appropriate update and installation instructions for the products that depend on the current one.

To completely remove the product from the user's device, execute, for example, the commands `su; make uninstall; rm -fr oux`.

# Other Licenses

This product includes software developed by the OpenSSL Project for use in the OpenSSL Toolkit (http://www.openssl.org/)
