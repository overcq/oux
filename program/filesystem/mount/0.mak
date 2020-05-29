##############################################################################
#   ___   workplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦/C+¦  filesystem
#   ---   mount
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒1‒6 #
################################################################################
S_headers := dirent.h
	ifeq (Linux,$(H_make_S_os))
S_headers := linux/fuse.h
S_libraries := cap
	else
S_headers := fuse.h
	endif
#===============================================================================
install:
	ln -fs /usr/sbin/mount.oux-fuse /usr/sbin/mount.oux \
	&& { $(CMP) a.out /usr/sbin/mount.oux-fuse \
	|| $(INSTALL) -m 755 a.out /usr/sbin/mount.oux-fuse; \
	}
uninstall:
	$(RM) /usr/sbin/mount.oux /usr/sbin/mount.oux-fuse
################################################################################
