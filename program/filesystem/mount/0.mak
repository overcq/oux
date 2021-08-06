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
H_make_S_install_file_1 = $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_install_prefix)/usr/sbin/mount.oux-fuse)
H_make_S_install_file_2 = $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_install_prefix)/usr/sbin/mount.oux)
install-1:
	ln -fs $(H_make_S_install_file_1) $(H_make_S_install_file_2) \
	&& { $(CMP) a.out $(H_make_S_install_file_1) \
	|| $(INSTALL) -m 755 a.out $(H_make_S_install_file_1); \
	}
uninstall-1:
	$(RM) $(H_make_S_install_file_1) $(H_make_S_install_file_2)
################################################################################
