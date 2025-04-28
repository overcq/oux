################################################################################
#   ___   publicplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦/C+¦  component
#   ---   ‟Xorg” —high ‘cpu’
#         module makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”             2015‒4‒28 #
################################################################################
S_packages := x11 xcb xcb-xkb
    ifeq (Linux,$(H_make_S_os))
S_packages += xkbcommon-x11
    else ifeq (NetBSD,$(H_make_S_os))
S_packages += xkbcommon-x11
    endif
S_libraries := m
S_headers := X11/keysym.h xcb/xcb.h xcb/xcb_event.h xcb/xcb_icccm.h xcb/xproto.h xcb/xkb.h
    ifeq (Linux,$(H_make_S_os))
S_headers += xkbcommon/xkbcommon-x11.h
    else ifeq (NetBSD,$(H_make_S_os))
S_headers += xkbcommon/xkbcommon-x11.h
    endif
    ifeq (,)
S_packages += xcb-shape
S_headers += xcb/shape.h
CFLAGS += -DC_xcb_shape
    endif
    ifeq (0,)
S_packages += xcb-glx
S_headers += xcb/glx.h
CFLAGS += -DC_xcb_glx
    endif
.SECONDARY: $(H_make_S_module_path)/gui-xcb/M.cx
$(H_make_S_module_path)/gui-xcb/M.cx: $(H_make_S_module_path)/gui-xcb/keysym-data.h \
$(wildcard $(H_make_S_module_path)/gui-xcb/wm-icon-data-*.h )
################################################################################
