##############################################################################
#   ___   workplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦Inc¦  file editor
#   ---   ncurses text editor
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒1‒6 #
################################################################################
#===============================================================================
install:
	{ $(CMP) a.out /usr/sbin/mkfs.oux \
	|| $(INSTALL) -m 755 a.out /usr/sbin/mkfs.oux; \
	}
uninstall:
	$(RM) /usr/sbin/mkfs.oux
################################################################################