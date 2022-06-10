#*******************************************************************************
#   ___   publicplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦/C+¦  component
#   ---   user interface
#         program makefile
# ©overcq                on ‟Gentoo Linux 17.1” “x86_64”             2022‒6‒10 U
#*******************************************************************************
	ifeq (OpenBSD,$(H_make_S_os))
S_libraries := ncurses
	else
S_packages := ncursesw
S_libraries := util
	endif
#*******************************************************************************
