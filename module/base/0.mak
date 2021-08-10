################################################################################
#   ___   publicplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦/C+¦  component
#   ---   base
#         module makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”             2015‒4‒28 #
################################################################################
S_packages := libssl
S_libraries := m
S_headers := errno.h limits.h signal.h sys/time.h time.h unistd.h
    ifeq ($(H_make_S_os),Linux)
S_packages += libpcreposix
S_headers += error.h
CFLAGS += -D_GNU_SOURCE
    else ifeq ($(H_make_S_os),OpenBSD)
S_headers += sys/param.h
CFLAGS += -D_BSD_SOURCE -D_XOPEN_SOURCE_EXTENDED
    endif
#-------------------------------------------------------------------------------
    ifneq (,$(and $(H_make_C_to_libs),$(H_make_C_to_libs_C_replace_c_alloc)))
        ifeq ($(H_make_S_os),Linux)
S_libraries += dl
        endif
CFLAGS += -DC_to_libs_C_replace_c_alloc
    endif
#-------------------------------------------------------------------------------
    ifneq (,$(E_flow_drv_C_clock_monotonic))
        ifeq ($(H_make_S_os),Linux)
S_libraries += rt
        endif
CFLAGS += -DE_flow_drv_C_clock_monotonic
    endif
#-------------------------------------------------------------------------------
    ifneq (,$(E_io_C_aio))
        ifneq ($(H_make_S_os),OpenBSD)
S_libraries += rt
CFLAGS += -DE_io_C_aio
        endif
    endif
################################################################################
