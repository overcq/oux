################################################################################
#   ___   publicplace
#  ¦OUX¦  GNU “make”
#  ¦/C+¦  component
#   ---   ‟Xorg” —high ‘cpu’
#         module makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”             2015‒4‒28 #
################################################################################
S_packages := wayland-client
S_headers := wayland-client.h
S_add_headers := xdg-shell-client-protocol.h
S_add_sources := xdg-shell-protocol.c
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.SECONDARY: $(H_make_S_module_path)/gui-wayland/xdg-shell-protocol.c $(H_make_S_module_path)/gui-wayland/xdg-shell-client-protocol.h
build-0: $(H_make_S_module_path)/gui-wayland/xdg-shell-protocol.c $(H_make_S_module_path)/gui-wayland/xdg-shell-client-protocol.h
$(H_make_S_module_path)/gui-wayland/xdg-shell-protocol.c: /usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml
	wayland-scanner private-code < $< > $(call H_make_Z_shell_cmd_arg_I_quote,$@)
$(H_make_S_module_path)/gui-wayland/xdg-shell-client-protocol.h: /usr/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml
	wayland-scanner client-header < $< > $(call H_make_Z_shell_cmd_arg_I_quote,$@)
distclean-0:
	rm -f $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/gui-wayland/xdg-shell-protocol.c) $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/gui-wayland/xdg-shell-client-protocol.h)
################################################################################
