################################################################################
#   ___   workplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦Inc¦  file editor
#   ---   ncurses text editor
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒1‒6 #
################################################################################
S_packages := ncursesw
S_headers := curses.h wctype.h
_ := 0.mak
#===============================================================================
install:
	gksu -D 'install tept' ' \
		$(INSTALL) -m 755 ../../oux_direct /usr/bin/oux_direct \
		&& ln -f /usr/bin/oux_direct /usr/bin/tept \
		&& $(INSTALL) -m 755 a.out /usr/bin/tept_indirect \
	'
################################################################################
