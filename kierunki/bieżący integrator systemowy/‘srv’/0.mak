################################################################################
#   ___   workplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦Inc¦  bieżący integrator systemowy
#   ---   server
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”             2015‒6‒27 #
################################################################################
S_headers := stdlib.h string.h unistd.h
#===============================================================================
install:
	$(INSTALL) -m 700 a.out "$${HOME}/lib/ocq-bis"
	-pkill -x ocq-bis
	fbrun -title 'run ocq-bis server' -text 'oux "$${HOME}/lib/ocq-bis"' >/dev/null 2>&1
################################################################################
