##############################################################################
#   ___   workplace
#  ¦OUX¦  GNU “make”
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
H_make_S_install_file = $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_install_prefix)/usr/sbin/mkfs.oux)
install-1:
	{ $(CMP) a.out $(H_make_S_install_file) \
	|| $(INSTALL) -m 755 a.out $(H_make_S_install_file); \
	}
uninstall-1:
	$(RM) $(H_make_S_install_file)
################################################################################
