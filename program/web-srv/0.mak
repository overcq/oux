################################################################################
#   ___   workplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦Inc¦  server
#   ---   web-server
#         program makefile
# ©overcq                on ‟Gentoo Linux 17.1” “x86_64”             2020‒4‒10 S
################################################################################
S_packages := libssl
install:
	{ $(CMP) /usr/bin/direct_oux /usr/bin/web-srv \
	|| ln -f /usr/bin/direct_oux /usr/bin/web-srv; \
	} \
	&& { $(CMP) a.out /usr/bin/indirect_web-srv \
	|| $(INSTALL) -m 755 a.out /usr/bin/indirect_web-srv; \
	}
uninstall:
	$(RM) /usr/bin/indirect_web-srv /usr/bin/web-srv
################################################################################
