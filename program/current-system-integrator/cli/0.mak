################################################################################
#   ___   workplace
#  ¦OUX¦  GNU “make”
#  ¦/C+¦  bieżący integrator systemowy
#   ---   client
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”             2015‒6‒27 #
################################################################################
H_make_S_install_file = $(call H_make_Z_shell_cmd_arg_I_quote,$(HOME)/bin/indirect-ocq)
install-1:
	$(H_make_I_block_root)
	ln -f $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_root_path)/direct-oux) $(call H_make_Z_shell_cmd_arg_I_quote,$(HOME)/bin/ocq)
	{ $(CMP) a.out $(H_make_S_install_file) \
	|| $(INSTALL) -C -m 700 a.out $(H_make_S_install_file); \
	}
uninstall-1:
	$(H_make_I_block_root)
	$(RM) $(H_make_S_install_file)
################################################################################
