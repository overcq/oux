#*******************************************************************************
#   ___   publicplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦/C+¦  component
#   ---   user interface
#         program makefile
# ©overcq                on ‟Gentoo Linux 17.1” “x86_64”             2022‒6‒10 U
#*******************************************************************************
    ifeq (Linux,$(H_make_S_os))
S_packages := ncursesw
    else ifeq (FreeBSD,$(H_make_S_os))
S_packages := ncursesw
    else ifeq (NetBSD,$(H_make_S_os))
S_packages := ncurses
    else ifeq (OpenBSD,$(H_make_S_os))
S_packages := ncursesw
	endif
S_libraries := m util
    ifeq (FreeBSD,$(H_make_S_os))
CFLAGS += -DNCURSES_WIDECHAR=1
	endif
S_headers := regex.h
#*******************************************************************************
