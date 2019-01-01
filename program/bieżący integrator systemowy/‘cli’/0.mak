################################################################################
#   ___   workplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦Inc¦  bieżący integrator systemowy
#   ---   client
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”             2015‒6‒27 #
################################################################################
install:
	ln -f $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_root_path)/direct_oux) "$(HOME)/bin/ocq"
	$(INSTALL) -C -m 700 a.out "$(HOME)/bin/indirect_ocq"
################################################################################
