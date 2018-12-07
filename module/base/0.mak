################################################################################
#   ___   publicplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦Inc¦  component
#   ---   base
#         module makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”             2015‒4‒28 #
################################################################################
S_libraries := m
S_headers := errno.h limits.h signal.h sys/time.h time.h
#S_headers := ctype.h math.h errno.h fcntl.h fenv.h locale.h sched.h signal.h stdarg.h stdbool.h stdio.h stdlib.h string.h sys/file.h sys/ipc.h sys/mman.h sys/shm.h sys/stat.h sys/time.h sys/types.h sys/wait.h termios.h time.h unistd.h
    ifeq ($(H_make_S_os),Linux)
S_headers += error.h
CFLAGS += -D_GNU_SOURCE
    else ifeq ($(H_make_S_os),OpenBSD)
S_headers += sys/param.h
CFLAGS += -D_BSD_SOURCE -D_XOPEN_SOURCE_EXTENDED
    endif
#-------------------------------------------------------------------------------
    ifneq (,$(and $(H_make_C_to_libs),$(H_make_C_to_libs_C_replace_c_alloc)))
#S_headers += dlfcn.h sys/sem.h
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
