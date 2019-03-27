##############################################################################
#   ___   workplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦Inc¦  file editor
#   ---   ncurses text editor
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒1‒6 #
################################################################################
S_libraries := cap
#===============================================================================
install:
	ln -fs /usr/sbin/mount.oux-fuse /usr/sbin/mount.oux \
	&& { $(CMP) a.out /usr/sbin/mount.oux-fuse \
	|| $(INSTALL) -m 755 a.out /usr/sbin/mount.oux-fuse; \
	}
uninstall:
	$(RM) /usr/sbin/mount.oux /usr/sbin/mount.oux-fuse
################################################################################
