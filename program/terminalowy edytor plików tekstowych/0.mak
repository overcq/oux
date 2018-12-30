##############################################################################
#   ___   workplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦Inc¦  file editor
#   ---   ncurses text editor
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒1‒6 #
################################################################################
S_packages := ncursesw
_ := E_coux_S_0_main_not_to_libs.h
#===============================================================================
install:
	gksu -D 'install tept' ' \
		$(INSTALL) -m 755 ../../direct_oux /usr/bin/direct_oux \
		&& ln -f /usr/bin/direct_oux /usr/bin/tept \
		&& $(INSTALL) -m 755 a.out /usr/bin/indirect_tept \
	'
################################################################################
