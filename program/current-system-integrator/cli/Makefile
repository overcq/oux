################################################################################
#   ___   publicplace
#  ¦OUX¦  GNU “make”
#  ¦/C+¦  compile
#   ---   C+
#         makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒1‒6 #
################################################################################
H_make_S_root_path := $(shell up=..; cd ..; while [ ! -e Makefile ]; do up="$${up}/.."; cd ..; done; echo -n "$$up" )
include $(H_make_S_root_path)/compile/1.mak
include 0.mak
include $(H_make_S_root_path)/compile/2.mak
################################################################################
