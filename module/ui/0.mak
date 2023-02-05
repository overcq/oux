#*******************************************************************************
#   ___   publicplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦/C+¦  component
#   ---   user interface
#         program makefile
# ©overcq                on ‟Gentoo Linux 17.1” “x86_64”             2022‒6‒10 U
#*******************************************************************************
S_packages := ncursesw
S_libraries := m util
    ifeq (FreeBSD,$(H_make_S_os))
CFLAGS += -DNCURSES_WIDECHAR=1
	endif
S_headers := regex.h
#*******************************************************************************
