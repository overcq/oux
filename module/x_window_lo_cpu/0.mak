################################################################################
#   ___   publicplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦Inc¦  component
#   ---   ‟Xorg” —low ‘cpu’
#         module makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”             2015‒4‒28 #
################################################################################
S_packages := x11 xcb
S_libraries := m
S_headers := X11/keysym.h xcb/xcb.h xcb/xcb_event.h xcb/xcb_icccm.h xcb/xproto.h
#“C_xcb_shape” do użycia tylko z własnymi oknami, pozwalającymi ‘serverowi’ ‟X” odświeżać bez migotania, ponieważ z ustawionej “pixmapy” tła.
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
.SECONDARY: $(H_make_S_module_path)/x_window_lo_cpu/M.cx
$(H_make_S_module_path)/x_window_lo_cpu/M.cx: $(H_make_S_module_path)/x_window_lo_cpu/_keysym_data.h \
$(wildcard $(H_make_S_module_path)/x_window_lo_cpu/_wm_icon_data_*.h )
################################################################################
