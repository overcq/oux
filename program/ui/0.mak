################################################################################
#   ___   laboratory
#  ¦OUX¦  GNU “make”
#  ¦/C+¦  ‘gui’ sample
#   ---   ‟X window”
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒1‒6 #
################################################################################
    ifeq (Linux,$(H_make_S_os))
S_modules := tui ui gui-wayland
    else ifeq (FreeBSD,$(H_make_S_os))
S_modules := tui gui-xcb
    else ifeq (NetBSD,$(H_make_S_os))
S_modules := tui gui-xcb
    else ifeq (OpenBSD,$(H_make_S_os))
S_modules := tui gui-xcb
	endif
################################################################################
