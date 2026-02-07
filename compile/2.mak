################################################################################
#   ___   publicplace
#  ¦OUX¦  GNU “make”
#  ¦/C+¦  compile
#   ---   C+
#         bottom include makefile
# ©overcq                on ‟Gentoo Linux 13.0” “x86_64”             2015‒1‒13 #
################################################################################
#DFN Standard dozwolonych znaków i sekwencji w nazwach w systemie plików: brak jakichkolwiek, które są interpretowane specjalnie przez “gmake”, gdy są one wstawiane z wyniku funkcji wbudowanej “gmake”, a nie literalnie. Czyli jeśli na przykład “gmake” przetwarza te nazwy od początku (np. “$(wildcard)”) do końca (interpretacja reguły wytworzenia pliku z parametrów “$”) jako referencje, to wtedy nie ma ograniczeń, ale znaki odstępu pomiędzy parametrami (beztypowa składni języka— lista “gmake”) nie wydają się podlegać tym ewentualnym referencjom wewnętrznym. Natomiast znaki interpretowane przez “shell” są globalnie ‘eskejpowane’ przed przekazaniem do wykonania w środowisku “shell”.
#DFN Jednak są inne, pozostałe jeszcze ograniczenia, powstające z wymaganych do ‘kompilacji’ form pośrednich: ‣otaczanie deklaracji (“#include”) w pliku nagłówkowym ‟C” znakami podwójnego cudzysłowu, co uniemożliwia użycie tego znaku w nazwach tych plików, ‣wybieranie plików w regule “gmake” z listy zależnych (“$^”), co uniemożliwia użycie odstępu także w ścieżkach do plików, ‣‘nieeskejpowalna’ funkcja “$(wildcard)”, co uniemożliwia użycie odstępu także w ścieżkach do plików.
# W przyszłości, gdy będzie możliwa ‘kompilacja’ naraz całego systemu programów ‘oux’ używających ‹modułów› w ‘dllach’, to o tym, czy po aktualizacji “biblioteki” bez zmiany ‘api’ używanego przez dany program będzie wymagana ‘rekompilacja’ programu— będzie decydować zmiana wartości automatycznie deterministycznie generowanych ‘uidów’ ‹raportów›/‹impulsatorów›,
#a to jest obecnie uzależnione od pozycji na sortowanej liście plików ‘cx’ sortowanej (oprócz “main”) listy ‹modułów› (czyli po dodaniu/usunięciu pliku nie położonego na końcu listy plików ostatniego z posortowanych ‹modułów›) oraz pozycji na sortowanej liście nazw ‹raportów› i ‹impulsatorów› z generatorów ‘uidów’ w tych plikach ‘cx’ (czyli po dodaniu/usunięciu ‹raportu›/‹impulsatora› nie położonego na końcu listy w danym pliku ‘cx’), a także przypuszczalnie dodatkowo będzie decydować jakaś zmiana pośredniego użycia ‹modułów› (szczególnie nowych) poprzez ‹moduły›, których już używa dany “zainstalowany” program ‘oux’ (jeśli dodawałbym po ‘kompilacji’ zależności ‹modułów› od ‹modułów›, to to ostatnie może nie byłoby potrzebne).
#TODO Zależność ‘rekompilacji’ od listy plików ‘cx’: dodania, usunięcia pliku.
#NDFN W ‘kompilacji’ do “bibliotek”— podczas tworzenia każdego pliku ‘kompilator’ otrzymuje wynik “pkg-config” tylko dla deklaracji “packages” tego, bieżącego ‹modułu›. Lista “bibliotek” wymaganych dla każdego ‹modułu› z osobna powinna być tak podawana, ale teksty pozostałe z “--libs” być może będą potrzebne z pozostałych ‹modułów›, by zachować integrację sposobu utworzenia każdego pliku. Jednak nie wiadomo, jak to rozumieć w sensie integralności ‘linkera’ wymaganej przez “packages”.
#DFN Podstawienie dla “bibliotek” procedur menedżera pamięci (w ‘kompilacji’ do “bibliotek”) zawsze będzie funkcjonalnością opcjonalną, mimo że bardzo stabilizuje, a także przyspiesza działanie programów “bibliotecznych” dołączanych do ‘kompilowanego’ programu oraz ich ‘serverów’ komunikacji, jednak otwiera “menedżera pamięci” na obce oprogramowanie, które nie jest gwarantowane, i w ten sposób eliminuje gwarancje dla całego programu, gdy byłaby realizowana niewłaściwa obsługa “menedżera pamięci” przez te obce programy.
#===============================================================================
# Linux fv-az202-994 5.13.0-1022-azure #26~20.04.1-Ubuntu SMP Thu Apr 7 19:42:45 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
    ifneq (,$(H_ocq_C_consent))
H_make_S_reports_consent := 1
    endif
H_make_S_compile_path := $(H_make_S_root_path)/compile
H_make_S_module_path := $(H_make_S_root_path)/module
H_make_S_base_module := base
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
H_make_Z_list_M_n = $(shell i=0; while [ $$i -ne $(1) ]; do i=$$(( $$i + 1 )); printf '%s ' $$i; done )
H_make_Z_list_I_index = $(strip $(foreach i,$(call H_make_Z_list_M_n,$(words $(2))),$(if $(filter $(word $(i),$(2)),$(1)),$(i))))
H_make_I_block_root = $(if $(filter 0,$(shell id -u)),$(error root user not allowed. Run make as user first.))
#===============================================================================
# Wczytanie plików (“0.mak”) definicji programu i ‹modułów›.
H_make_S_modules := $(H_make_S_base_module) $(sort $(filter-out $(H_make_S_base_module),$(S_modules)))
undefine S_modules
#-------------------------------------------------------------------------------
    ifeq (,$(H_make_C_to_libs))

    ifeq (OpenBSD,$(H_make_S_os))
S_packages := $(filter-out ncurses ncursesw,$(S_packages))
	ifeq (ncurses,$(filter ncurses,$(S_packages)))
S_libraries := ncurses $(S_libraries)
	else ifeq (ncursesw,$(filter ncursesw,$(S_packages)))
S_libraries := ncursesw $(S_libraries)
	endif
    endif
E_main_S_packages := $(S_packages)
S_packages :=
E_main_S_libraries := $(S_libraries)
S_libraries :=
E_main_S_headers := $(S_headers)
S_headers :=
        ifeq (,$(H_make_C_pthreads))
H_make_C_pthreads := $(if $(C_pthreads),1)
        endif
E_main_S_add_headers := $(S_add_headers)
S_add_headers :=
E_main_S_add_sources := $(S_add_sources)
S_add_sources :=

        define H_make_I_module
include $$(H_make_S_module_path)/$(1)/0.mak
    ifeq (OpenBSD,$$(H_make_S_os))
S_packages := $$(filter-out ncurses ncursesw,$$(S_packages))
	ifeq (ncurses,$$(filter ncurses,$$(S_packages)))
S_libraries := ncurses $$(S_libraries)
	else ifeq (ncursesw,$$(filter ncursesw,$$(S_packages)))
S_libraries := ncursesw $$(S_libraries)
	endif
    endif
E_main_S_packages += $$(S_packages)
S_packages :=
E_main_S_libraries += $$(S_libraries)
S_libraries :=
E_main_S_headers += $$(S_headers)
S_headers :=
E_main_S_add_headers += $$(addprefix $$(H_make_S_module_path)/$(1)/,$$(S_add_headers))
S_add_headers :=
E_main_S_add_sources += $$(addprefix $$(H_make_S_module_path)/$(1)/,$$(S_add_sources))
S_add_sources :=
            ifeq (,$$(H_make_C_pthreads))
H_make_C_pthreads := $$(if $$(C_pthreads),1)
            endif
        endef

$(foreach module,$(H_make_S_modules),$(if $(wildcard $(H_make_S_module_path)/$(module)/0.mak),$(eval $(call H_make_I_module,$(module)))))

E_main_S_packages := $(sort $(E_main_S_packages))
E_main_S_libraries := $(sort $(E_main_S_libraries))
E_main_S_headers := $(sort $(E_main_S_headers))
E_main_S_add_headers := $(sort $(E_main_S_add_headers))
E_main_S_add_sources := $(sort $(E_main_S_add_sources))

    else

    ifeq (OpenBSD,$(H_make_S_os))
	ifeq (ncurses,$(filter ncurses,$(S_packages)))
S_libraries := ncurses $(S_libraries)
	else ifeq (ncursesw,$(filter ncursesw,$(S_packages)))
S_libraries := ncursesw $(S_libraries)
	endif
S_packages := $(filter-out ncurses ncursesw,$(S_packages))
    endif
E_main_S_packages := $(sort $(S_packages))
S_packages :=
E_main_S_libraries := $(sort $(S_libraries))
S_libraries :=
E_main_S_headers := $(sort $(S_headers))
S_headers :=
        ifeq (,$(H_make_C_pthreads))
H_make_C_pthreads := $(if $(C_pthreads),1)
        endif
E_main_S_add_headers := $(sort $(S_add_headers))
S_add_headers :=
E_main_S_add_sources := $(sort $(S_add_sources))
S_add_sources :=

E_module_S_packages :=
E_module_S_headers :=

        define H_make_I_module
include $$(H_make_S_module_path)/$(1)/0.mak
    ifeq (OpenBSD,$$(H_make_S_os))
	ifeq (ncurses,$$(filter ncurses,$$(S_packages)))
S_libraries := ncurses $$(S_libraries)
	else ifeq (ncursesw,$$(filter ncursesw,$$(S_packages)))
S_libraries := ncursesw $$(S_libraries)
	endif
S_packages := $$(filter-out ncurses ncursesw,$$(S_packages))
    endif
$$(eval E_$(2)_S_packages := $$$$(sort $$$$(S_packages)))
S_packages :=
E_module_S_packages += $$(E_$(2)_S_packages)
$$(eval E_$(2)_S_libraries := $$$$(sort $$$$(S_libraries)))
S_libraries :=
E_module_S_headers += $$(S_headers)
S_headers :=
            ifeq (,$$(H_make_C_pthreads))
H_make_C_pthreads := $$(if $$(C_pthreads),1)
            endif
E_main_S_add_headers += $$(addprefix $$(H_make_S_module_path)/$(1)/,$$(S_add_headers))
S_add_headers :=
E_main_Q_$(subst -,_,$(1))_S_add_sources := $$(addprefix $$(H_make_S_module_path)/$(1)/,$$(sort $$(S_add_sources)))
S_add_sources :=
        endef

$(foreach module,$(H_make_S_modules),$(if $(wildcard $(H_make_S_module_path)/$(module)/0.mak),$(eval $(call H_make_I_module,$(module),$(call H_make_Z_list_I_index,$(module),$(H_make_S_modules))))))

E_module_S_packages := $(sort $(E_module_S_packages))
E_module_S_headers := $(sort $(E_module_S_headers))
E_main_S_add_headers := $(sort $(E_main_S_add_headers))

    endif

undefine H_make_I_module
undefine S_packages
undefine S_libraries
undefine S_headers
undefine C_pthreads
#===============================================================================
H_make_S_lib_prefix := oux-
#-------------------------------------------------------------------------------
#NDFN Wymienione, ponieważ są inne pliki “.h” w tym katalogu.
H_make_S_compiler_cx_sources := simple.h base.h
H_make_S_cx_sources := $(wildcard *.cx)
H_make_S_all_cx_sources := $(foreach module,$(H_make_S_modules),$(wildcard $(H_make_S_root_path)/module/$(module)/*.cx)) $(H_make_S_cx_sources)
H_make_S_headers := stdbool.h assert.h
H_make_S_base_driver := flow-drv
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
H_make_Z_shell_cmd_arg_I_quote = '$(subst ','\'',$(1))'
H_make_Z_shell_cmd_arg_I_quote_for = $(foreach s,$(1),$(call H_make_Z_shell_cmd_arg_I_quote,$(s)))
H_make_Z_headers_I_sort = $(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(1)) | tr ' ' '\n' | grep -Fve / | sort -u; echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(1)) | tr ' ' '\n' | grep -Fe / | sort -u )
#-------------------------------------------------------------------------------
H_make_Z_shell_cmd_N_gen_headers_db := $(H_make_S_compile_path)/E_cplus_M_headers_db.sh
H_make_Z_shell_cmd_N_cx_to_c := $(H_make_S_compile_path)/E_cplus_I_compile_N_cx_to_c.sh
H_make_Z_shell_cmd_N_c_to_h := $(H_make_S_compile_path)/E_cplus_I_compile_N_c_to_h.sh
H_make_Q_packages_R_cflags = $(if $(1),$(shell pkg-config --cflags $(call H_make_Z_shell_cmd_arg_I_quote_for,$(1))))
H_make_Q_packages_R_ldflags = $(if $(1),$(filter-out -l%,$(shell pkg-config --libs $(call H_make_Z_shell_cmd_arg_I_quote_for,$(1)))))
H_make_Q_packages_R_ldlibs = $(if $(1),$(filter -l%,$(shell pkg-config --libs $(call H_make_Z_shell_cmd_arg_I_quote_for,$(1)))))
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    ifneq (,$(filter Linux OpenBSD,$(H_make_S_os)))
H_make_T_pthreads := $(if $(shell whatis pthreads),1)
    else ifneq (,$(filter FreeBSD NetBSD,$(H_make_S_os)))
H_make_T_pthreads := $(if $(shell whatis pthread),1)
    endif
#===============================================================================
# Ustawienie parametrów z przełączników ‘kompilacji’.
    ifneq (,$(H_make_C_middle_code))
CFLAGS += -DC_middle_code -ffreestanding
#H_make_C_pthreads := 1
#CFLAGS += -DE_flow_C_thread_system_unblock_reports
        ifeq (OpenBSD,$(H_make_S_os)) # “sigwait”
H_make_C_pthreads := 1
        endif
    else
        ifneq (,$(H_make_C_to_libs))
CFLAGS += -DC_to_libs -DE_flow_C_itimer_system_unblock_report
            ifneq (,$(H_make_T_pthreads))
H_make_C_pthreads := 1
CFLAGS += -DE_flow_C_thread_system_unblock_reports
            endif
        else
            ifneq (,$(shell grep -Fwqe Xh1_M $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_all_cx_sources)) && echo 1))
CFLAGS += -DE_flow_C_itimer_system_unblock_report
            endif
            ifneq (,$(and $(H_make_T_pthreads),$(shell grep -Fwqe Xh_A $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_all_cx_sources)) && echo 1)))
H_make_C_pthreads := 1
CFLAGS += -DE_flow_C_thread_system_unblock_reports
            endif
        endif
    endif
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Ustawienie parametrów dostępnego podsystemu ‘kompilacji’.
    ifneq (,$(H_make_C_pthreads))
H_make_S_headers += pthread.h
CFLAGS += -DC_pthreads -pthread
    endif
#-------------------------------------------------------------------------------
    ifneq (,$(filter $(H_make_S_cc),gcc clang))
#NDFN Przełącznik “gnu”, który i tak nie byłby potrzebny, jeśli przy przełączniku “c” ‘kompilator’ stosowałby “builtiny” (eliminujące dane znane w czasie ‘kompilacji’) dla procedur takich jak “strcmp” (używanych jakkolwiek tylko dla składni wewnętrznej, a nie jako podstawa własnych funkcji).
H_make_S_c_std_alt := gnu
    endif
    ifeq (clang,$(H_make_S_cc))
# Tylko spekulacje wersji “clang” obsługujących standardy ‟C”.
		ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 18.0) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)23
		else ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 9.0) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)2x -Dalignof=_Alignof
		else ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 6.0) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)17 -Dalignof=_Alignof
		else ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 5.0) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)14 -Dalignof=_Alignof
		else ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 4.0) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)11 -Dalignof=_Alignof
		endif
CFLAGS += -O1 -finline -Qunused-arguments -Wno-incompatible-pointer-types-discards-qualifiers
    else #nie “clang”.
        ifeq (gcc,$(H_make_S_cc))
			ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 14.0) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)23
            else ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 9) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)2x -Dalignof=_Alignof
            else ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 8.3) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)17 -Dalignof=_Alignof
            else ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 4.7) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)11 -Dalignof=_Alignof
CFLAGS += -fno-signed-zeros
            else ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) = 4.6) | bc )) #“gcc” z “c1x”
CFLAGS += -std=$(H_make_S_c_std_alt)1x
            else ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 2.95) | bc )) #“gcc” bez “c11”
CFLAGS += -std=$(H_make_S_c_std_alt)99
                ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 4.3) | bc ))
CFLAGS += -fno-signed-zeros
                endif
            else #“gcc” bez “c99”
$(error gcc too old)
            endif
            ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) <= 4.4) | bc ))
CFLAGS += -D_unreachable=no
            endif
undefine H_make_S_words
undefine H_make_S_number
        else #nie “clang”, nie “gcc”
CFLAGS += -std=c99 -D_unreachable=no
        endif
CFLAGS += -O2 -Wno-overflow
        ifneq (OpenBSD,$(H_make_S_os))
CFLAGS += -Wno-old-style-declaration -Wno-shift-negative-value
		endif
    endif
CFLAGS += -fno-common -Wall -Wextra -Wno-missing-braces -Wno-parentheses -Wno-sign-compare -Wstrict-prototypes -Wno-switch -Wno-unused-parameter \
-fno-builtin-memset -fno-stack-protector -fno-trapping-math -fwrapv \
-pipe
    ifeq (clang,$(H_make_S_cc))
CFLAGS += -flto -Wa,-emit-llvm
    endif
#-------------------------------------------------------------------------------
    ifeq (,$(H_make_C_debug))
CFLAGS += -DNDEBUG
    endif
    ifneq (,$(E_mem_Q_blk_C_debug))
CFLAGS += -DE_mem_Q_blk_C_debug
    endif
#-------------------------------------------------------------------------------
    ifeq (Linux,$(H_make_S_os))
LDFLAGS += -Wl,--gc-sections,--as-needed
    endif
LDFLAGS += -Wl,--enable-new-dtags
#-------------------------------------------------------------------------------
TARGET_ARCH += -march=native
#===============================================================================
# Definicje wytworzenia.
.PHONY: all \
  build build-0 build-1 install install-0 install-1 uninstall uninstall-0 uninstall-1 \
  recompile rebuild \
  mostlyclean clean distclean distclean-0 distclean-1 maintainer-clean \
  run rebuild-run
.DEFAULT: all
#-------------------------------------------------------------------------------
build: build-0 build-1
build-1: a.out
distclean: distclean-0 distclean-1
install: install-0 install-1
uninstall: uninstall-1
recompile: mostlyclean build
rebuild: clean build
run: build
rebuild-run: rebuild run
#-------------------------------------------------------------------------------
.SECONDARY: $(H_make_S_compile_path)/headers-db \
0.mak 0.h $(foreach module,$(H_make_S_modules),$(addprefix $(H_make_S_module_path)/$(module)/,0.mak 0.h)) \
E_cplus_S_not_to_libs.h $(H_make_S_module_path)/E_cplus_S_to_libs.h \
E_cplus_S_cx_sources $(H_make_S_module_path)/E_cplus_S_cx_sources \
$(patsubst %.cx,E_cplus_S_0_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,E_cplus_S_1_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,E_cplus_S_2_%.h,$(H_make_S_cx_sources)) \
$(foreach module,$(H_make_S_modules),$(addprefix $(H_make_S_module_path)/$(module)/,$(patsubst %.cx,E_cplus_S_0_$(module)__%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))) $(patsubst %.cx,E_cplus_S_1_$(module)__%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))) $(patsubst %.cx,E_cplus_S_2_$(module)__%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))))) \
$(patsubst %.cx,%.c,$(H_make_S_all_cx_sources))
0.mak 0.h $(foreach module,$(H_make_S_modules),$(addprefix $(H_make_S_module_path)/$(module)/,0.mak 0.h)):
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
H_make_Q_stat_S_url := https://overcq.ct8.pl/p.php?event=
H_make_Q_stat_S_machine_id := 1c8150f752614dec80f88752256e829f
H_make_Q_stat_I_stat = if [ ! -e /etc/machine-id -o "$$(cat /etc/machine-id )" != $(H_make_Q_stat_S_machine_id) ]; then curl -s '$(H_make_Q_stat_S_url)$(1)' >/dev/null || wget -qO /dev/null '$(H_make_Q_stat_S_url)$(1)' || true; fi
    ifeq ($(H_make_Q_stat_S_machine_id),$(shell cat /etc/machine-id))
H_make_S_reports_consent := 1
    endif
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    define H_make_Q_main_header_I_module_0
for header in $(addprefix $(call H_make_Z_shell_cmd_arg_I_quote,$(1)/),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,E_cplus_S_0_$(1)__%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(1)/*.cx))))); do \
    echo "#include \"$${header}\"" ;\
done
    endef

    define H_make_Q_main_header_I_module_0h
if [ -e $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(1)/0.h) ]; then \
    echo $(call H_make_Z_shell_cmd_arg_I_quote,#include "$(1)/0.h") ;\
fi
    endef

    define H_make_Q_main_header_I_module_1
for header in $(addprefix $(call H_make_Z_shell_cmd_arg_I_quote,$(1)/),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,E_cplus_S_1_$(1)__%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(1)/*.cx))))); do \
    echo "#include \"$${header}\"" ;\
done
    endef

    define H_make_Q_main_header_I_module_2
for header in $(addprefix $(call H_make_Z_shell_cmd_arg_I_quote,$(1)/),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,E_cplus_S_2_$(1)__%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(1)/*.cx))))); do \
    echo "#include \"$${header}\"" ;\
done
    endef
#-------------------------------------------------------------------------------
$(H_make_S_compile_path)/headers-db: $(H_make_Z_shell_cmd_N_gen_headers_db)
	$(H_make_I_block_root)
	msg='The installer of this program and the program itself sends usage reports to the developer. Do you agree to this and continue building the program?' ;\
    if [ -z '$(H_make_S_reports_consent)' ]; then \
        tty -s ;\
        if [ $$? = 0 ]; then \
            echo -n "$$msg [Yn] "; read REPLY;\
            [ "$$REPLY" = '' -o "$$REPLY" = 'y' -o "$$REPLY" = 'Y' ] || false ;\
        else \
            which Xdialog >/dev/null 2>&1 ;\
            if [ $$? = 0 ]; then \
                Xdialog --yesno "$$msg" 0 0 ;\
                [ $$? = 0 ] || false ;\
            else \
                false ;\
            fi \
        fi \
    fi ;\
	echo 'Wait patiently for the header database needed for the operating system procedures to build...' ;\
	$(H_make_Z_shell_cmd_N_gen_headers_db) > $(call H_make_Z_shell_cmd_arg_I_quote,$@)
#-------------------------------------------------------------------------------
E_cplus_S_not_to_libs.h: \
$(H_make_Z_shell_cmd_N_cx_to_c) \
$(addprefix $(H_make_S_compile_path)/,1.mak 2.mak) \
0.mak $(foreach module,$(H_make_S_modules),$(H_make_S_module_path)/$(module)/0.mak) \
E_cplus_S_cx_sources $(H_make_S_module_path)/E_cplus_S_cx_sources \
$(E_main_S_add_headers)
	$(H_make_I_block_root)
	{   for include in $(call H_make_Z_shell_cmd_arg_I_quote_for,$(call H_make_Z_headers_I_sort,$(H_make_S_headers) $(E_main_S_headers) $(E_module_S_headers))); do \
            echo "#include <$${include}>" ;\
        done ;\
        for header in $(call H_make_Z_shell_cmd_arg_I_quote_for,$(E_main_S_add_headers)); do \
            echo "#include \"$${header}\"" ;\
        done ;\
        $(foreach module,$(H_make_S_modules),$(call H_make_Q_main_header_I_module_0,$(module));) \
        for header in $(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,E_cplus_S_0_%.h,$(H_make_S_cx_sources))); do \
            echo "#include \"$${header}\"" ;\
        done ;\
        echo '#include "E_cplus_S_machine.h"' ;\
        echo '#include "E_cplus_S_language.h"' ;\
        $(H_make_Z_shell_cmd_N_cx_to_c) -f $(foreach module,$(notdir $(wildcard $(H_make_S_module_path)/*)),$(addprefix $(call H_make_Z_shell_cmd_arg_I_quote,$(module)/),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(sort $(patsubst %.cx,%,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))))))) $(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,%,$(H_make_S_cx_sources))) ;\
        $(if $(H_make_C_to_libs), \
        $(H_make_Z_shell_cmd_N_cx_to_c) -h1_ $(foreach module,$(H_make_S_modules),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(wildcard $(H_make_S_root_path)/module/$(module)/*.cx))) ;\
        ) \
        $(foreach module,$(H_make_S_modules),$(call H_make_Q_main_header_I_module_0h,$(module));) \
        if [ -e 0.h ]; then \
            echo "#include \"0.h\"" ;\
        fi ;\
        $(foreach module,$(H_make_S_modules),$(call H_make_Q_main_header_I_module_1,$(module));) \
        for header in $(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,E_cplus_S_1_%.h,$(H_make_S_cx_sources))); do \
            echo "#include \"$${header}\"" ;\
        done ;\
        $(foreach module,$(H_make_S_modules),$(call H_make_Q_main_header_I_module_2,$(module));) \
        for header in $(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,E_cplus_S_2_%.h,$(H_make_S_cx_sources))); do \
            echo "#include \"$${header}\"" ;\
        done ;\
    } > $(call H_make_Z_shell_cmd_arg_I_quote,$@)

    ifneq (,$(H_make_C_to_libs))
$(H_make_S_module_path)/E_cplus_S_to_libs.h: \
$(H_make_Z_shell_cmd_N_cx_to_c) \
$(addprefix $(H_make_S_compile_path)/,1.mak 2.mak) \
0.mak $(foreach module,$(H_make_S_modules),$(addprefix $(H_make_S_module_path)/$(module)/,0.mak)) \
$(H_make_S_module_path)/E_cplus_S_cx_sources
	$(H_make_I_block_root)
	{   $(if $(H_make_C_to_libs_C_replace_c_alloc), \
        echo "#define C_to_libs_C_replace_c_alloc_S_libc_filename J_s($(shell ldd $$( which $(MAKE) ) | grep -Fw libc.so | head -n 1 | sed -e 's`^.*\(libc\.so[0-9A-Za-z.-]*\).*`\1`' ))" ;\
        ) \
        for header in $(call H_make_Z_shell_cmd_arg_I_quote_for,$(call H_make_Z_headers_I_sort,$(H_make_S_headers) $(E_module_S_headers))); do \
            echo "#include <$${header}>" ;\
        done ;\
        for header in $(call H_make_Z_shell_cmd_arg_I_quote_for,$(E_main_S_add_headers)); do \
            echo "#include \"$${header#*/}\"" ;\
        done ;\
        $(foreach module,$(H_make_S_modules),$(call H_make_Q_main_header_I_module_0,$(module));) \
        echo '#include "E_cplus_S_machine.h"' ;\
        echo '#include "E_cplus_S_language.h"' ;\
        $(H_make_Z_shell_cmd_N_cx_to_c) -f $(foreach module,$(notdir $(wildcard $(H_make_S_module_path)/*)),$(addprefix $(call H_make_Z_shell_cmd_arg_I_quote,$(module)/),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(sort $(patsubst %.cx,%,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))))))) $(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,%,$(H_make_S_cx_sources))) ;\
        $(H_make_Z_shell_cmd_N_cx_to_c) -h1_ $(foreach module,$(H_make_S_modules),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(wildcard $(H_make_S_root_path)/module/$(module)/*.cx))) ;\
        $(foreach module,$(H_make_S_modules),$(call H_make_Q_main_header_I_module_0h,$(module));) \
        $(foreach module,$(H_make_S_modules),$(call H_make_Q_main_header_I_module_1,$(module));) \
        $(foreach module,$(H_make_S_modules),$(call H_make_Q_main_header_I_module_2,$(module));) \
    } > $(call H_make_Z_shell_cmd_arg_I_quote,$@)
    endif

    ifneq (,$(H_make_C_to_libs))
E_cplus_S_cx_sources: \
$(H_make_S_cx_sources)
    else
E_cplus_S_cx_sources: \
$(H_make_S_all_cx_sources)
    endif
	$(H_make_I_block_root)
	if [ ! -e $(call H_make_Z_shell_cmd_arg_I_quote,$@) ] || [ "$$(cat $(call H_make_Z_shell_cmd_arg_I_quote,$@))" != $(call H_make_Z_shell_cmd_arg_I_quote,$^) ]; then \
        echo -n $(call H_make_Z_shell_cmd_arg_I_quote,$^) > $(call H_make_Z_shell_cmd_arg_I_quote,$@); \
    fi

$(H_make_S_module_path)/E_cplus_S_cx_sources: \
$(foreach module,$(H_make_S_modules),$(wildcard $(H_make_S_module_path)/$(module)/*.cx))
	$(H_make_I_block_root)
	if [ ! -e $(call H_make_Z_shell_cmd_arg_I_quote,$@) ] || [ "$$(cat $(call H_make_Z_shell_cmd_arg_I_quote,$@))" != $(call H_make_Z_shell_cmd_arg_I_quote,$^) ]; then \
        echo -n $(call H_make_Z_shell_cmd_arg_I_quote,$^) > $(call H_make_Z_shell_cmd_arg_I_quote,$@); \
    fi

    define H_make_I_module_header_0
E_cplus_S_0_$(1)__%.h: %.c \
$$(H_make_S_compile_path)/headers-db \
$$(H_make_Z_shell_cmd_N_c_to_h)
	$$(H_make_I_block_root)
	$$(H_make_Z_shell_cmd_N_c_to_h) $$(call H_make_Z_shell_cmd_arg_I_quote,$$(H_make_S_compile_path)/headers-db) \
	$$(call H_make_Z_shell_cmd_arg_I_quote,$$<) \
	> $$(call H_make_Z_shell_cmd_arg_I_quote,$$@)
    endef
$(foreach module,$(H_make_S_modules),$(eval $(call H_make_I_module_header_0,$(module))))
E_cplus_S_0_%.h: %.c \
$(H_make_S_compile_path)/headers-db \
$(H_make_Z_shell_cmd_N_c_to_h)
	$(H_make_I_block_root)
	$(H_make_Z_shell_cmd_N_c_to_h) $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_compile_path)/headers-db) \
	$(call H_make_Z_shell_cmd_arg_I_quote,$<) \
	> $(call H_make_Z_shell_cmd_arg_I_quote,$@)

    define H_make_I_module_header_1
E_cplus_S_1_$(1)__%.h: %.cx \
$$(H_make_Z_shell_cmd_N_cx_to_c) \
$$(addprefix $$(H_make_S_compile_path)/,1.mak 2.mak) \
$$(if $$(H_make_C_to_libs),$$(H_make_S_module_path)/E_cplus_S_to_libs.h)
	$$(H_make_I_block_root)
	{   $$(H_make_Z_shell_cmd_N_cx_to_c) -h1 $$(call H_make_Z_shell_cmd_arg_I_quote,$$<)$$(if $$(H_make_C_to_libs), $$(call H_make_Z_shell_cmd_arg_I_quote,$$(H_make_S_module_path)/E_cplus_S_to_libs.h)) \
        && $$(H_make_Z_shell_cmd_N_cx_to_c) -h2 $$(call H_make_Z_shell_cmd_arg_I_quote,$$<) ;\
    } > $$(call H_make_Z_shell_cmd_arg_I_quote,$$@)
    endef
$(foreach module,$(H_make_S_modules),$(eval $(call H_make_I_module_header_1,$(module))))

E_cplus_S_1_%.h: %.cx \
$(H_make_Z_shell_cmd_N_cx_to_c) \
$(addprefix $(H_make_S_compile_path)/,1.mak 2.mak) \
$(if $(H_make_C_to_libs),$(H_make_S_module_path)/E_cplus_S_to_libs.h)
	$(H_make_I_block_root)
	{   $(H_make_Z_shell_cmd_N_cx_to_c) -h1 $(call H_make_Z_shell_cmd_arg_I_quote,$<)$(if $(H_make_C_to_libs), $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/E_cplus_S_to_libs.h)) \
        && $(H_make_Z_shell_cmd_N_cx_to_c) -h2 $(call H_make_Z_shell_cmd_arg_I_quote,$<) ;\
    } > $(call H_make_Z_shell_cmd_arg_I_quote,$@)

    define H_make_I_module_header_2
E_cplus_S_2_$(1)__%.h: %.cx \
$$(H_make_Z_shell_cmd_N_cx_to_c) \
$$(addprefix $$(H_make_S_compile_path)/,1.mak 2.mak)
	$$(H_make_I_block_root)
	$$(H_make_Z_shell_cmd_N_cx_to_c) -h3 $$(call H_make_Z_shell_cmd_arg_I_quote,$$<) > $$(call H_make_Z_shell_cmd_arg_I_quote,$$@)
    endef
$(foreach module,$(H_make_S_modules),$(eval $(call H_make_I_module_header_2,$(module))))

E_cplus_S_2_%.h: %.cx \
$(H_make_Z_shell_cmd_N_cx_to_c) \
$(addprefix $(H_make_S_compile_path)/,1.mak 2.mak)
	$(H_make_I_block_root)
	$(H_make_Z_shell_cmd_N_cx_to_c) -h3 $(call H_make_Z_shell_cmd_arg_I_quote,$<) > $(call H_make_Z_shell_cmd_arg_I_quote,$@)

%.c: %.cx \
$(H_make_Z_shell_cmd_N_cx_to_c) \
$(addprefix $(H_make_S_compile_path)/,1.mak 2.mak)
	$(H_make_I_block_root)
	$(H_make_Z_shell_cmd_N_cx_to_c) -c $(call H_make_Z_shell_cmd_arg_I_quote,$<) > $(call H_make_Z_shell_cmd_arg_I_quote,$@)
#-------------------------------------------------------------------------------
    ifeq (,$(H_make_C_to_libs))

a.out: \
$(addprefix $(H_make_S_compile_path)/,E_cplus_S_machine.h E_cplus_S_language.h $(H_make_S_compiler_cx_sources)) \
0.mak E_cplus_S_not_to_libs.h 0.h \
$(patsubst %.cx,E_cplus_S_0_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,E_cplus_S_1_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,E_cplus_S_2_%.h,$(H_make_S_cx_sources)) \
$(foreach module,$(H_make_S_modules),$(addprefix $(H_make_S_module_path)/$(module)/,0.mak 0.h $(patsubst %.cx,E_cplus_S_0_$(module)__%.h,$(notdir $(wildcard $(H_make_S_root_path)/module/$(module)/*.cx))) $(patsubst %.cx,E_cplus_S_1_$(module)__%.h,$(notdir $(wildcard $(H_make_S_root_path)/module/$(module)/*.cx))) $(patsubst %.cx,E_cplus_S_2_$(module)__%.h,$(notdir $(wildcard $(H_make_S_root_path)/module/$(module)/*.cx))))) \
$(patsubst %.cx,%.c,$(H_make_S_cx_sources) $(foreach module,$(H_make_S_modules),$(wildcard $(H_make_S_module_path)/$(module)/*.cx))) \
$(E_main_S_add_sources)
	$(H_make_I_block_root)
	$(call H_make_Q_stat_I_stat,0)
	$(CC) $(call H_make_Q_packages_R_cflags,$(E_main_S_packages)) $(CFLAGS) $(call H_make_Q_packages_R_ldflags,$(E_main_S_packages)) $(LDFLAGS) $(TARGET_ARCH) -fPIE -pie -s -iquote $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_compile_path)) -iquote $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)) -include E_cplus_S_not_to_libs.h $(addprefix -include ,$(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_compiler_cx_sources))) $(call H_make_Z_shell_cmd_arg_I_quote_for,$(filter %.c,$^)) -o $(call H_make_Z_shell_cmd_arg_I_quote,$@) $(addprefix -l,$(call H_make_Z_shell_cmd_arg_I_quote_for,$(E_main_S_libraries))) $(call H_make_Q_packages_R_ldlibs,$(E_main_S_packages))

    else

        define H_make_Q_lib_M
$$(H_make_S_module_path)/$(1)/%.lo: $$(H_make_S_module_path)/$(1)/%.c \
$$(addprefix $$(H_make_S_compile_path)/,E_cplus_S_machine.h E_cplus_S_language.h $$(H_make_S_compiler_cx_sources)) \
$$(H_make_S_module_path)/E_cplus_S_to_libs.h \
$$(foreach module,$$(H_make_S_modules),$$(addprefix $$(H_make_S_module_path)/$$(module)/,0.mak 0.h $$(patsubst %.cx,E_cplus_S_0_$$(module)__%.h,$$(notdir $$(wildcard $$(H_make_S_module_path)/$$(module)/*.cx))) $$(patsubst %.cx,E_cplus_S_1_$$(module)__%.h,$$(notdir $$(wildcard $$(H_make_S_module_path)/$$(module)/*.cx))) $$(patsubst %.cx,E_cplus_S_2_$$(module)__%.h,$$(notdir $$(wildcard $$(H_make_S_module_path)/$$(module)/*.cx))))) \
$$(E_main_Q_$(subst -,_,$(1))_S_add_headers)
	$$(H_make_I_block_root)
	$$(LIBTOOL) --quiet --mode=compile --tag=CC $$(CC) $$(call H_make_Q_packages_R_cflags,$$(E_module_S_packages)) $$(CFLAGS) $$(TARGET_ARCH) -shared -prefer-pic -c -iquote $$(call H_make_Z_shell_cmd_arg_I_quote,$$(H_make_S_compile_path)) -iquote $$(call H_make_Z_shell_cmd_arg_I_quote,$$(H_make_S_module_path)) -include E_cplus_S_to_libs.h $$(addprefix -include ,$$(call H_make_Z_shell_cmd_arg_I_quote_for,$$(H_make_S_compiler_cx_sources))) $$(call H_make_Z_shell_cmd_arg_I_quote,$$<) -o $$(call H_make_Z_shell_cmd_arg_I_quote,$$@)
$$(H_make_S_module_path)/$(1)/lib$$(H_make_S_lib_prefix)$(1).so: $$(patsubst %.cx,%.lo,$$(wildcard $$(H_make_S_module_path)/$(1)/*.cx)) $$(patsubst %.c,%.lo,$$(E_main_Q_$(subst -,_,$(1))_S_add_sources))
	$$(LIBTOOL) --quiet --mode=link --tag=CC $$(CC) $$(call H_make_Q_packages_R_cflags,$$(E_module_S_packages)) $$(CFLAGS) $$(call H_make_Q_packages_R_ldflags,$$(E_$(2)_S_packages)) $$(LDFLAGS) $$(TARGET_ARCH) -s -shared -fPIC -Wc,-shared -Wc,-fPIC $$(call H_make_Z_shell_cmd_arg_I_quote_for,$$^) -o $$(call H_make_Z_shell_cmd_arg_I_quote,$$@) $$(addprefix -l,$$(call H_make_Z_shell_cmd_arg_I_quote_for,$$(E_$(2)_S_libraries))) $$(call H_make_Q_packages_R_ldlibs,$$(E_$(2)_S_packages))
        endef

$(foreach module,$(H_make_S_modules),$(eval $(call H_make_Q_lib_M,$(module),$(call H_make_Z_list_I_index,$(module),$(H_make_S_modules)))))
        undefine H_make_Q_lib_M

a.out: \
0.mak E_cplus_S_not_to_libs.h 0.h \
$(patsubst %.cx,E_cplus_S_0_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,E_cplus_S_1_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,E_cplus_S_2_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,%.c,$(H_make_S_cx_sources)) \
$(foreach module,$(H_make_S_modules),$(H_make_S_module_path)/$(module)/lib$(H_make_S_lib_prefix)$(module).so) \
$(E_main_S_add_sources)
	$(H_make_I_block_root)
	$(call H_make_Q_stat_I_stat,0)
	$(CC) $(call H_make_Q_packages_R_cflags,$(sort $(E_module_S_packages) $(E_main_S_packages))) $(CFLAGS) $(call H_make_Q_packages_R_ldflags,$(E_main_S_packages)) $(LDFLAGS) $(TARGET_ARCH) -fPIE -pie -s -iquote $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_compile_path)) -iquote $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)) -include E_cplus_S_not_to_libs.h $(addprefix -include ,$(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_compiler_cx_sources))) $(call H_make_Z_shell_cmd_arg_I_quote_for,$(filter %.c,$^)) -o $(call H_make_Z_shell_cmd_arg_I_quote,$@) $(foreach module,$(H_make_S_modules),-L$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module))) $(foreach module,$(H_make_S_modules),-l$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_lib_prefix)$(module))) $(addprefix -l,$(call H_make_Z_shell_cmd_arg_I_quote_for,$(E_main_S_libraries))) $(call H_make_Q_packages_R_ldlibs,$(E_main_S_packages))

    endif
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Definicje czyszczenia katalogów.
    define H_make_I_libtool_I_clean
$(LIBTOOL) --mode=clean $(RM) $(1) ;\
if [ -e $(2) ]; then \
    $(RM) -r $(1) $(3) ;\
fi
    endef
#-------------------------------------------------------------------------------
mostlyclean:
	$(RM) a.out
    ifneq (,$(H_make_C_to_libs))
	$(call H_make_I_libtool_I_clean,$(foreach module,$(H_make_S_modules),$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module)/lib$(H_make_S_lib_prefix)$(module).so)),$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(H_make_S_base_module)/lib$(H_make_S_lib_prefix)$(H_make_S_base_module).so))
	$(call H_make_I_libtool_I_clean,$(foreach module,$(H_make_S_modules),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,%.lo,$(wildcard $(H_make_S_module_path)/$(module)/*.cx)))),$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(H_make_S_base_module)/$(H_make_S_base_driver).lo),$(foreach module,$(H_make_S_modules),$(addprefix $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module)/.libs/),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,%.o,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx)))))) $(foreach module,$(H_make_S_modules),$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module)/.libs)))
    endif

clean: mostlyclean
	$(RM) $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/E_cplus_S_to_libs.h) E_cplus_S_not_to_libs.h \
      $(H_make_S_module_path)/E_cplus_S_cx_sources E_cplus_S_cx_sources \
      $(foreach module,$(H_make_S_modules),$(addprefix $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module)/),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,E_cplus_S_0_$(module)__%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))) $(patsubst %.cx,E_cplus_S_1_$(module)__%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))) $(patsubst %.cx,E_cplus_S_2_$(module)__%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))) $(patsubst %.cx,%.c,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx)))))) \
      $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/E_cplus_S_to_libs.h) \
      $(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,E_cplus_S_0_%.h,$(H_make_S_cx_sources)) $(patsubst %.cx,E_cplus_S_1_%.h,$(H_make_S_cx_sources)) $(patsubst %.cx,E_cplus_S_2_%.h,$(H_make_S_cx_sources)) $(patsubst %.cx,%.c,$(H_make_S_cx_sources))) \

distclean-1: clean
	$(RM) $(H_make_S_compile_path)/headers-db

maintainer-clean: distclean
	$(RM) -r $(foreach module,$(H_make_S_modules),$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module)/.libs))
	$(RM) $(foreach module,$(H_make_S_modules),$(addprefix $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module)/),*.so *.o E_cplus_S_0_$(module)__*.h E_cplus_S_1_$(module)__*.h E_cplus_S_2_$(module)__*.h *.c)) \
      *.o E_cplus_S_0_*.h E_cplus_S_1_*.h E_cplus_S_2_*.h *.c
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Uruchamianie rezultatu nie zainstalowanego.
run:
	$(H_make_I_block_root)
	$(call H_make_Q_stat_I_stat,3)
	libs=$(if $(H_make_C_to_libs),"$$( "$$SHELL" -c ' \
	    if [ -n "$$1" ]; then \
	        s="$$1" ;\
	        shift; \
	        while [ -n "$$1" ]; do \
	            s="$${s}:$$1" ;\
	            shift; \
	        done; \
	    fi; \
	    printf %s "$$s"' \
	    "$$SHELL" \
	    $(foreach module,$(H_make_S_modules),$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module))))") ;\
    cmd=' \
    trap sleep\ 1000 EXIT ;\
    cd "$$1" || exit 1 ;\
    shift; \
    $(if $(H_make_C_to_libs),libs="$$1" ;\
      shift ;\
      LD_LIBRARY_PATH="$$libs" \
      $(if $(H_make_C_to_libs_C_replace_c_alloc), LD_PRELOAD=lib$(H_make_S_lib_prefix)$(H_make_S_base_module).so)) \
    ./a.out "$$@" ;\
    r=$$? ;\
    pkill -x gui-srv-gtk ;\
    pkill -x gui-srv-qt ;\
    exit $$r' ;\
    if [ -z "$$( set | grep -e ^DISPLAY= )" ]; then \
		$(if $(H_make_C_to_libs),LD_LIBRARY_PATH="$$libs" \
		  $(if $(H_make_C_to_libs_C_replace_c_alloc), LD_PRELOAD=lib$(H_make_S_lib_prefix)$(H_make_S_base_module).so)) \
		./a.out $(call H_make_Z_shell_cmd_arg_I_quote_for,$(S_cmd_arg)) ;\
        r=$$? ;\
        pkill -x gui-srv-gtk ;\
        pkill -x gui-srv-qt ;\
        exit $$r ;\
	elif [ -n "$$( which ocq 2>/dev/null )" ]; then \
        ocq term-args "$$cmd" "$$SHELL" "$$PWD" $(if $(H_make_C_to_libs),"$$libs") $(call H_make_Z_shell_cmd_arg_I_quote_for,$(S_cmd_arg)) ;\
    elif [ -n "$$( which xterm 2>/dev/null )" ]; then \
        xterm -maximized -e "$$SHELL" -c "$$cmd" "$$SHELL" "$$PWD" $(if $(H_make_C_to_libs),"$$libs") $(call H_make_Z_shell_cmd_arg_I_quote_for,$(S_cmd_arg)) ;\
    else \
        $(if $(H_make_C_to_libs), LD_LIBRARY_PATH="$$libs" \
          $(if $(H_make_C_to_libs_C_replace_c_alloc) \
          , LD_PRELOAD=lib$(H_make_S_lib_prefix)$(H_make_S_base_module).so)) \
        ./a.out $(call H_make_Z_shell_cmd_arg_I_quote_for,$(S_cmd_arg)) ;\
        r=$$? ;\
        pkill -x gui-srv-gtk ;\
        pkill -x gui-srv-qt ;\
        exit $$r ;\
    fi
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
install-0:
	$(call H_make_Q_stat_I_stat,1)
	tmp_file=$$( mktemp ) ;\
	trap '$(RM) "$$tmp_file"' EXIT ;\
	{ echo '#!/bin/sh' ;\
	$(if $(H_make_C_to_libs_C_replace_c_alloc),echo 'exec env LD_PRELOAD=lib$(H_make_S_lib_prefix)$(H_make_S_base_module).so "$$@"',echo 'exec "$$@"'); } > "$$tmp_file" ;\
	{ $(CMP) "$$tmp_file" $(H_make_S_install_prefix)/usr/bin/oux \
	|| $(INSTALL) -m 755 "$$tmp_file" $(H_make_S_install_prefix)/usr/bin/oux; \
	} \
	&& { $(CMP) $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_root_path)/direct-oux) $(H_make_S_install_prefix)/usr/bin/direct-oux \
	|| $(INSTALL) -m 755 $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_root_path)/direct-oux) $(H_make_S_install_prefix)/usr/bin/direct-oux; \
	} \
	$(if $(H_make_C_to_libs),$(foreach module,$(H_make_S_modules), && { $(CMP) $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module)/lib$(H_make_S_lib_prefix)$(module).so) $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_install_prefix)$(H_make_S_install_usr_lib)/lib$(H_make_S_lib_prefix)$(module).so) \
        || $(INSTALL) -m 755 $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module)/lib$(H_make_S_lib_prefix)$(module).so) $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_install_prefix)$(H_make_S_install_usr_lib)/lib$(H_make_S_lib_prefix)$(module).so); \
        } \
    ))
#-------------------------------------------------------------------------------
uninstall-0:
	$(call H_make_Q_stat_I_stat,2)
	$(RM) $(foreach module,$(H_make_S_modules),$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_install_prefix)$(H_make_S_install_usr_lib)/lib$(H_make_S_lib_prefix)$(module).so))
################################################################################
