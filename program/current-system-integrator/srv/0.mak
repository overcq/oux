################################################################################
#   ___   workplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦/C+¦  bieżący integrator systemowy
#   ---   server
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”             2015‒6‒27 #
################################################################################
H_make_S_install_file = $(call H_make_Z_shell_cmd_arg_I_quote,$(HOME)/lib/ocq-csi)
install-1:
	$(H_make_I_block_root)
	{ $(CMP) a.out $(H_make_S_install_file) \
	|| $(INSTALL) -C -m 700 a.out $(H_make_S_install_file); \
	}
	-pkill -x ocq-csi
	fbrun -title 'run ocq-bis server' -text 'oux "$(HOME)/lib/ocq-csi"' >/dev/null 2>&1
uninstall-1:
	$(H_make_I_block_root)
	$(RM) $(H_make_S_install_file)
################################################################################
