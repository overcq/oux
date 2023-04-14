################################################################################
#   ___   workplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦/C+¦  terminal command
#   ---   backup list
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒1‒6 #
################################################################################
S_libraries := cap
build-1:
	$(H_make_I_block_root)
	sudo setcap cap_sys_admin=p /home/inc/moje/programy/oux/program/backup-list/a.out
################################################################################
