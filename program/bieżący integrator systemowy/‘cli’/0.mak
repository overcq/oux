################################################################################
#   ___   workplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦Inc¦  bieżący integrator systemowy
#   ---   client
#         program makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”             2015‒6‒27 #
################################################################################
S_headers := ctype.h dirent.h errno.h fcntl.h stdlib.h string.h sys/stat.h sys/types.h unistd.h
#===============================================================================
install:
	$(INSTALL) -m 700 ../ocq "$${HOME}/bin/"
	$(INSTALL) -m 700 a.out "$${HOME}/bin/ocq_indirect"
################################################################################
