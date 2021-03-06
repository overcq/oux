###############################################################################
#   ___   publicplace
#  ¦OUX¦  ‟GNU” “make”
#  ¦/C+¦  compile
#   ---   C+
#         top include makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”             2015‒1‒13 #
################################################################################
#NDFN Nie wiadomo, gdzie umieszczać poniższe przełączniki.
# Obecnie pliki “0.mak” nie mogą zawierać ustawiania “H_make_”[…], chyba że usystematyzuje się sposób włączania tych przełączników.
# Są dostępne następujące rodzaje programu wynikowego:
#•jeden plik wykonywalny, zależny tylko od “bibliotek” systemu operacyjnego. domyślnie.
#•plik wykonywalny zależny od ‹modułów› tworzonych tutaj jako ‘dll’ (“to libs”). oszczędza pamięć, gdy jest używany kolejny program.
#•program do uruchomienia instrukcją wpisaną pomiędzy innym programem (“middle code”). tekst programu do tego jest już przygotowany, ale brak sposobu konfiguracji i ‘kompilacji’ docelowej —w “2.mak”.
H_make_C_to_libs := 1
#H_make_C_to_libs_C_replace_c_alloc := 1
#H_make_C_middle_code := 1
# Przełącza na zegar nanosekundowy ‟POSIX 2008” (z pozastandardowymi rozszerzeniami) zamiast milisekundowego ‟POSIX 2001”. te nowe mogą być odporne na nieakceptowalne ustawianie zegara systemowego, więc powinno być włączone. rozdzielczość nanosekundowa i tak nie jest potrzebna lub wykorzystywana.
E_flow_drv_C_clock_monotonic := 1
# Wybiera ‟POSIX” “aio” zamiast “strumieni asynchronicznych” ‟BSD” (“O_ASYNC”). generalnie– “wątkowane” “aio” nie jest potrzebne. żadne nie jest gwarantowane bezczasowo ze względu na brak metody znalezienia wartości “E_io_Q_stream_out_S_delay”, ograniczającej możliwe opóźnienie systemu operacyjnego przed oddaniem użycia “aiocb” (dla “aio”) lub “aio_buf” (dla “O_ASYNC”).
E_io_C_aio := 1
# Czy włączyć wewnętrzne testy poprawności?
H_make_C_debug := 1
# Włącza kontrolę poprawności pamięci ‘alokatora’ bloków.
#E_mem_Q_blk_C_debug := 1
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
H_make_S_usr_lib := $(if $(wildcard /usr/lib64/libc.so),/usr/lib64,/usr/lib)
CMP := cmp -s
INSTALL := install
LIBTOOL := libtool
#===============================================================================
H_make_S_os := $(shell uname -s)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Wybór ‘kompilatora’.
H_make_S_cc := clang gcc
#-------------------------------------------------------------------------------
H_make_S_cc := $(firstword $(foreach cc,$(H_make_S_cc),$(wildcard $(addsuffix /$(cc),/usr/bin /usr/local/bin \
  $(shell clang -print-search-dirs | awk '/^programs:/ { match( $$2, /[=:]\/usr\/lib\/llvm\/[^:]*/ ); print substr( $$2, RSTART + 1, RLENGTH - 1 ); }' ) \
  $(shell gcc-config -B )))))
    ifneq (,$(H_make_S_cc))
CC := $(H_make_S_cc)
H_make_S_cc_version := $(shell $(H_make_S_cc) -dumpversion | sed -e 's`^\([0-9][0-9]*\.[0-9][0-9]*\).*`\1`' )
H_make_S_cc := $(notdir $(H_make_S_cc))
    else
H_make_S_cc := $(CC)
H_make_S_cc_version := $(shell $(H_make_S_cc) -dumpversion | sed -e 's`^\([0-9][0-9]*\.[0-9][0-9]*\).*`\1`' )
    endif
#===============================================================================
    ifneq (,$(H_make_C_middle_code))
undefine H_make_C_to_libs
    endif
#===============================================================================
all: build
################################################################################
