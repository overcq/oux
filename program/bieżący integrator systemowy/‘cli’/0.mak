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
	ln -f ../../../direct_oux "$${HOME}/bin/ocq"
	$(INSTALL) -m 700 a.out "$${HOME}/bin/indirect_ocq"
################################################################################
