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
S_cmd_arg := test
#===============================================================================
H_make_S_installed_file = $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_install_prefix)/usr/bin/direct-oux)
H_make_S_install_file_1 = $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_install_prefix)/usr/bin/tept)
H_make_S_install_file_2 = $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_install_prefix)/usr/bin/indirect_tept)
install:
	{ $(CMP) $(H_make_S_installed_file) $(H_make_S_install_file_1) \
	|| ln -f $(H_make_S_installed_file) $(H_make_S_install_file_1); \
	} \
	&& { $(CMP) a.out $(H_make_S_install_file_2) \
	|| $(INSTALL) -m 755 a.out $(H_make_S_install_file_2); \
	}
uninstall:
	$(RM) $(H_make_S_install_file_1) $(H_make_S_install_file_2)
################################################################################
