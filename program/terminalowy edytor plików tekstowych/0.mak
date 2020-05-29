##############################################################################
#   ___   workplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦/C+¦  file editor
#   ---   ncurses text editor
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒1‒6 #
################################################################################
	ifeq (OpenBSD,$(H_make_S_os))
S_libraries := ncurses
	else
S_packages := ncursesw
	endif
_ := test
#===============================================================================
install:
	{ $(CMP) /usr/bin/direct_oux /usr/bin/tept \
	|| ln -f /usr/bin/direct_oux /usr/bin/tept; \
	} \
	&& { $(CMP) a.out /usr/bin/indirect_tept \
	|| $(INSTALL) -m 755 a.out /usr/bin/indirect_tept; \
	}
uninstall:
	$(RM) /usr/bin/indirect_tept /usr/bin/tept
################################################################################
