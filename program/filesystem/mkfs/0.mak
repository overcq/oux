##############################################################################
#   ___   workplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦/C+¦  filesystem
#   ---   mkfs
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒1‒6 #
################################################################################
	ifeq (Linux,$(H_make_S_os))
S_headers := linux/fuse.h
	else
S_headers := fuse.h
	endif
#===============================================================================
install:
	{ $(CMP) a.out /usr/sbin/mkfs.oux \
	|| $(INSTALL) -m 755 a.out /usr/sbin/mkfs.oux; \
	}
uninstall:
	$(RM) /usr/sbin/mkfs.oux
################################################################################
