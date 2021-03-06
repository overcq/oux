################################################################################
#   ___   publicplace
#  ¦OUX¦  ‟GNU” “make”
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
H_make_S_compile_path := $(H_make_S_root_path)/compile
H_make_S_module_path := $(H_make_S_root_path)/module
H_make_S_base_module := base
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
H_make_Z_list_M_n = $(shell i=0; while [ $$i -ne $(1) ]; do i=$$(( $$i + 1 )); printf '%s ' $$i; done )
H_make_Z_list_I_index = $(strip $(foreach i,$(call H_make_Z_list_M_n,$(words $(2))),$(if $(filter $(word $(i),$(2)),$(1)),$(i))))
#===============================================================================
# Wczytanie plików (“0.mak”) definicji programu i ‹modułów›.
#NDFN Są wymieniane, a mogłyby być automatycznie generowane, gdyby nie było modułów alternatywnych, np. “x-window-lo-cpu” i “x-window-hi-cpu”.
H_make_S_modules := $(H_make_S_base_module) $(sort $(filter-out $(H_make_S_base_module),$(S_modules)))
undefine S_modules
#-------------------------------------------------------------------------------
    ifeq (,$(H_make_C_to_libs))

E_main_S_packages := $(S_packages)
S_packages :=
E_main_S_libraries := $(S_libraries)
S_libraries :=
E_main_S_headers := $(S_headers)
S_headers :=
        ifeq (,$(H_make_C_pthreads))
H_make_C_pthreads := $(if $(C_pthreads),1)
        endif

        define H_make_I_module
include $$(H_make_S_module_path)/$(1)/0.mak
E_main_S_packages += $$(S_packages)
S_packages :=
E_main_S_libraries += $$(S_libraries)
S_libraries :=
E_main_S_headers += $$(S_headers)
S_headers :=
            ifeq (,$$(H_make_C_pthreads))
H_make_C_pthreads := $$(if $$(C_pthreads),1)
            endif
        endef

$(foreach module,$(H_make_S_modules),$(if $(wildcard $(H_make_S_module_path)/$(module)/0.mak),$(eval $(call H_make_I_module,$(module)))))

E_main_S_packages := $(sort $(E_main_S_packages))
E_main_S_libraries := $(sort $(E_main_S_libraries))
E_main_S_headers := $(sort $(E_main_S_headers))

    else

E_main_S_packages := $(sort $(S_packages))
S_packages :=
E_main_S_libraries := $(sort $(S_libraries))
S_libraries :=
E_main_S_headers := $(sort $(S_headers))
S_headers :=
        ifeq (,$(H_make_C_pthreads))
H_make_C_pthreads := $(if $(C_pthreads),1)
        endif
E_module_S_packages :=
E_module_S_headers :=

        define H_make_I_module
include $$(H_make_S_module_path)/$(1)/0.mak
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

        endef

$(foreach module,$(H_make_S_modules),$(if $(wildcard $(H_make_S_module_path)/$(module)/0.mak),$(eval $(call H_make_I_module,$(module),$(call H_make_Z_list_I_index,$(module),$(H_make_S_modules))))))

E_module_S_packages := $(sort $(E_module_S_packages))
E_module_S_headers := $(sort $(E_module_S_headers))

    endif

    undefine H_make_I_module
    undefine S_packages
    undefine S_libraries
    undefine S_headers
    undefine C_pthreads
#-------------------------------------------------------------------------------
    ifneq (,$(filter ncursesw,$(E_main_S_packages)))
        ifeq (OpenBSD,$(H_make_S_os))
S_packages := $(filter-out ncursesw,$(E_main_S_packages))
S_libraries := $(sort ncursesw $(E_main_S_libraries))
        endif
    endif
#===============================================================================
H_make_S_lib_prefix := oux-
#-------------------------------------------------------------------------------
#NDFN Wymienione, ponieważ są inne pliki “.h” w tym katalogu.
H_make_S_compiler_cx_sources := simple.h base.h
H_make_S_cx_sources := $(wildcard *.cx)
H_make_S_headers := stdbool.h
H_make_S_base_driver := flow_drv
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
H_make_Z_shell_cmd_arg_I_quote = '$(subst ','\'',$(1))'
H_make_Z_shell_cmd_arg_I_quote_for = $(foreach s,$(1),$(call H_make_Z_shell_cmd_arg_I_quote,$(s)))
#-------------------------------------------------------------------------------
H_make_Z_shell_cmd_N_gen_headers_db := $(H_make_S_compile_path)/E_cplus_M_headers_db.sh
H_make_Z_shell_cmd_N_cx_to_c := $(H_make_S_compile_path)/E_cplus_I_compile_N_cx_to_c.sh
H_make_Z_shell_cmd_N_c_to_h := $(H_make_S_compile_path)/E_cplus_I_compile_N_c_to_h.sh
H_make_Q_packages_R_cflags = $(if $(1),$(shell pkg-config --cflags $(call H_make_Z_shell_cmd_arg_I_quote_for,$(1))))
H_make_Q_packages_R_ldflags = $(if $(1),$(filter-out -l%,$(shell pkg-config --libs $(call H_make_Z_shell_cmd_arg_I_quote_for,$(1)))))
H_make_Q_packages_R_ldlibs = $(if $(1),$(filter -l%,$(shell pkg-config --libs $(call H_make_Z_shell_cmd_arg_I_quote_for,$(1)))))
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
H_make_T_pthreads := $(if $(shell whatis pthreads),1)
#===============================================================================
# Ustawienie parametrów z przełączników ‘kompilacji’.
    ifneq (,$(H_make_C_middle_code))
CFLAGS += -DC_middle_code -ffreestanding
#H_make_C_pthreads := 1
#CFLAGS += -DE_flow_C_thread_system_unblock_reports
        ifeq (OpenBSD,$(H_make_S_os)) #“sigwait”.
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
#NDFN Wymyślenie zależności przełącznikowej, by nie potrzebował za każdym razem przeglądać plików ‘cx’.
            ifneq (,$(shell grep -Fwqe Xh1_M $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cx_sources)) && echo 1))
CFLAGS += -DE_flow_C_itimer_system_unblock_report
            endif
            ifneq (,$(and $(H_make_T_pthreads),$(shell grep -Fwqe Xh_A $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cx_sources) $(foreach module,$(H_make_S_modules),$(wildcard $(H_make_S_root_path)/module/$(module)/*.cx))) && echo 1)))
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
		ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 9.0) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)17
		else ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 5.0) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)14
		else ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 4.0) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)11
		endif
CFLAGS += -O1 -finline -Qunused-arguments -Wno-incompatible-pointer-types-discards-qualifiers
    else #nie “clang”.
        ifeq (gcc,$(H_make_S_cc))
            ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 8.3) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)17
            else ifneq (0,$(shell echo $(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_cc_version) >= 4.7) | bc ))
CFLAGS += -std=$(H_make_S_c_std_alt)11
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
CFLAGS += -pedantic -fno-common -Wall -Wextra -Wno-missing-braces -Wno-parentheses -Wno-sign-compare -Wstrict-prototypes -Wno-unused-parameter \
-fno-stack-protector -fno-trapping-math -fwrapv \
-pipe
    ifeq (clang,$(H_make_S_cc))
        ifeq (Linux,$(H_make_S_os))
CFLAGS += -flto -Wa,-emit-llvm
        endif
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
  build install-0 install uninstall-0 uninstall \
  recompile rebuild \
  mostlyclean clean distclean \
  run rebuild-run
.DEFAULT: all
#-------------------------------------------------------------------------------
build: a.out
install: install-0
uninstall: uninstall-0
recompile: mostlyclean build
rebuild: distclean build
rebuild-run: rebuild run
#-------------------------------------------------------------------------------
.SECONDARY: $(H_make_S_compile_path)/headers-db \
0.mak 0.h $(foreach module,$(H_make_S_modules),$(addprefix $(H_make_S_module_path)/$(module)/,0.mak 0.h)) \
E_cplus_S_0_main_not_to_libs.h $(H_make_S_module_path)/E_cplus_S_0_to_libs.h \
E_cplus_S_cx_sources $(H_make_S_module_path)/E_cplus_S_cx_sources \
$(patsubst %.cx,E_cplus_S_0_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,E_cplus_S_1_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,E_cplus_S_2_%.h,$(H_make_S_cx_sources)) \
$(foreach module,$(H_make_S_modules),$(addprefix $(H_make_S_module_path)/$(module)/,$(patsubst %.cx,E_cplus_S_0_%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))) $(patsubst %.cx,E_cplus_S_1_%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))) $(patsubst %.cx,E_cplus_S_2_%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))))) \
$(patsubst %.cx,%.c,$(H_make_S_cx_sources) $(foreach module,$(H_make_S_modules),$(wildcard $(H_make_S_module_path)/$(module)/*.cx)))
0.mak 0.h $(foreach module,$(H_make_S_modules),$(addprefix $(H_make_S_module_path)/$(module)/,0.mak 0.h)):
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    define H_make_Q_main_header_I_module_0
for header in $(addprefix $(call H_make_Z_shell_cmd_arg_I_quote,$(1)/),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,E_cplus_S_0_%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(1)/*.cx))))); do \
    echo "#include \"$${header}\"" ;\
done
    endef

    define H_make_Q_main_header_I_module_0h
if [ -e $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(1)/0.h) ]; then \
    echo $(call H_make_Z_shell_cmd_arg_I_quote,#include "$(1)/0.h") ;\
fi
    endef

    define H_make_Q_main_header_I_module_1
for header in $(addprefix $(call H_make_Z_shell_cmd_arg_I_quote,$(1)/),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,E_cplus_S_1_%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(1)/*.cx))))); do \
    echo "#include \"$${header}\"" ;\
done
    endef

    define H_make_Q_main_header_I_module_2
for header in $(addprefix $(call H_make_Z_shell_cmd_arg_I_quote,$(1)/),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,E_cplus_S_2_%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(1)/*.cx))))); do \
    echo "#include \"$${header}\"" ;\
done
    endef
#-------------------------------------------------------------------------------
$(H_make_S_compile_path)/headers-db: $(H_make_Z_shell_cmd_N_gen_headers_db)
	echo 'Wait patiently for the header database needed for the operating system procedures to build...'
	$(H_make_Z_shell_cmd_N_gen_headers_db) > $(call H_make_Z_shell_cmd_arg_I_quote,$@)
#-------------------------------------------------------------------------------
E_cplus_S_0_main_not_to_libs.h: \
$(H_make_Z_shell_cmd_N_cx_to_c) \
$(addprefix $(H_make_S_compile_path)/,1.mak 2.mak) \
0.mak $(foreach module,$(H_make_S_modules),$(H_make_S_module_path)/$(module)/0.mak) \
E_cplus_S_cx_sources $(H_make_S_module_path)/E_cplus_S_cx_sources
	{   $(if $(H_make_S_headers) $(E_main_S_headers) $(E_module_S_headers), \
        for include in $(call H_make_Z_shell_cmd_arg_I_quote_for,$(sort $(H_make_S_headers) $(E_main_S_headers) $(E_module_S_headers))); do \
            echo "#include <$${include}>" ;\
        done ;\
        ) \
        echo '#include <assert.h>' ;\
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
$(H_make_S_module_path)/E_cplus_S_0_to_libs.h: \
$(H_make_Z_shell_cmd_N_cx_to_c) \
$(addprefix $(H_make_S_compile_path)/,1.mak 2.mak) \
0.mak $(foreach module,$(H_make_S_modules),$(addprefix $(H_make_S_module_path)/$(module)/,0.mak)) \
$(H_make_S_module_path)/E_cplus_S_cx_sources
	{   $(if $(H_make_C_to_libs_C_replace_c_alloc), \
        echo "#define C_to_libs_C_replace_c_alloc_S_libc_filename J_s($(shell ldd $$( which $(MAKE) ) | grep -Fw libc.so | head -n 1 | sed -e 's`^.*\(libc\.so[0-9A-Za-z.-]*\).*`\1`' ))" ;\
        ) \
        $(if $(H_make_S_headers) $(E_module_S_headers), \
        for header in $(call H_make_Z_shell_cmd_arg_I_quote_for,$(sort $(H_make_S_headers) $(E_module_S_headers))); do \
            echo "#include <$${header}>" ;\
        done ;\
        ) \
        echo '#include <assert.h>' ;\
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
$(foreach module,$(H_make_S_modules),$(wildcard $(H_make_S_module_path)/$(module)/*.cx)) \
$(H_make_S_cx_sources)
    endif
	if [ ! -e $(call H_make_Z_shell_cmd_arg_I_quote,$@) -o "$$( cat $(call H_make_Z_shell_cmd_arg_I_quote,$@))" != $(call H_make_Z_shell_cmd_arg_I_quote,$^) ]; then \
        echo -n $(call H_make_Z_shell_cmd_arg_I_quote,$^) > $(call H_make_Z_shell_cmd_arg_I_quote,$@); \
    else \
		touch $(call H_make_Z_shell_cmd_arg_I_quote,$@); \
    fi

$(H_make_S_module_path)/E_cplus_S_cx_sources: \
$(foreach module,$(H_make_S_modules),$(wildcard $(H_make_S_module_path)/$(module)/*.cx))
	if [ ! -e $(call H_make_Z_shell_cmd_arg_I_quote,$@) -o "$$( cat $(call H_make_Z_shell_cmd_arg_I_quote,$@))" != $(call H_make_Z_shell_cmd_arg_I_quote,$^) ]; then \
        echo -n $(call H_make_Z_shell_cmd_arg_I_quote,$^) > $(call H_make_Z_shell_cmd_arg_I_quote,$@); \
    else \
		touch $(call H_make_Z_shell_cmd_arg_I_quote,$@); \
    fi

E_cplus_S_0_%.h: %.c \
$(H_make_S_compile_path)/headers-db \
$(H_make_Z_shell_cmd_N_c_to_h)
	$(H_make_Z_shell_cmd_N_c_to_h) $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_compile_path)/headers-db) \
	$(call H_make_Z_shell_cmd_arg_I_quote,$<) \
	> $(call H_make_Z_shell_cmd_arg_I_quote,$@)

E_cplus_S_1_%.h: %.cx \
$(H_make_Z_shell_cmd_N_cx_to_c) \
$(addprefix $(H_make_S_compile_path)/,1.mak 2.mak) \
$(if $(H_make_C_to_libs),$(H_make_S_module_path)/E_cplus_S_0_to_libs.h)
	{   $(H_make_Z_shell_cmd_N_cx_to_c) -h1 $(call H_make_Z_shell_cmd_arg_I_quote,$<)$(if $(H_make_C_to_libs), $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/E_cplus_S_0_to_libs.h)) \
        && $(H_make_Z_shell_cmd_N_cx_to_c) -h2 $(call H_make_Z_shell_cmd_arg_I_quote,$<) ;\
    } > $(call H_make_Z_shell_cmd_arg_I_quote,$@)

E_cplus_S_2_%.h: %.cx \
$(H_make_Z_shell_cmd_N_cx_to_c) \
$(addprefix $(H_make_S_compile_path)/,1.mak 2.mak)
	$(H_make_Z_shell_cmd_N_cx_to_c) -h3 $(call H_make_Z_shell_cmd_arg_I_quote,$<) > $(call H_make_Z_shell_cmd_arg_I_quote,$@)

%.c: %.cx \
$(H_make_Z_shell_cmd_N_cx_to_c) \
$(addprefix $(H_make_S_compile_path)/,1.mak 2.mak)
	$(H_make_Z_shell_cmd_N_cx_to_c) -c $(call H_make_Z_shell_cmd_arg_I_quote,$<) > $(call H_make_Z_shell_cmd_arg_I_quote,$@)
#-------------------------------------------------------------------------------
    ifeq (,$(H_make_C_to_libs))

a.out: \
$(addprefix $(H_make_S_compile_path)/,E_cplus_S_machine.h E_cplus_S_language.h $(H_make_S_compiler_cx_sources)) \
0.mak E_cplus_S_0_main_not_to_libs.h 0.h \
$(patsubst %.cx,E_cplus_S_0_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,E_cplus_S_1_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,E_cplus_S_2_%.h,$(H_make_S_cx_sources)) \
$(foreach module,$(H_make_S_modules),$(addprefix $(H_make_S_module_path)/$(module)/,0.mak 0.h $(patsubst %.cx,E_cplus_S_0_%.h,$(notdir $(wildcard $(H_make_S_root_path)/module/$(module)/*.cx))) $(patsubst %.cx,E_cplus_S_1_%.h,$(notdir $(wildcard $(H_make_S_root_path)/module/$(module)/*.cx))) $(patsubst %.cx,E_cplus_S_2_%.h,$(notdir $(wildcard $(H_make_S_root_path)/module/$(module)/*.cx))))) \
$(patsubst %.cx,%.c,$(H_make_S_cx_sources) $(foreach module,$(H_make_S_modules),$(wildcard $(H_make_S_module_path)/$(module)/*.cx)))
	$(CC) $(call H_make_Q_packages_R_cflags,$(E_main_S_packages)) $(CFLAGS) $(call H_make_Q_packages_R_ldflags,$(E_main_S_packages)) $(LDFLAGS) $(TARGET_ARCH) -fPIE -pie -s -iquote$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_compile_path)) -iquote$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)) -include E_cplus_S_0_main_not_to_libs.h $(addprefix -include ,$(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_compiler_cx_sources))) $(call H_make_Z_shell_cmd_arg_I_quote_for,$(filter %.c,$^)) -o $(call H_make_Z_shell_cmd_arg_I_quote,$@) $(addprefix -l,$(call H_make_Z_shell_cmd_arg_I_quote_for,$(E_main_S_libraries))) $(call H_make_Q_packages_R_ldlibs,$(E_main_S_packages))

    else

        define H_make_Q_lib_M
$$(H_make_S_module_path)/$(1)/%.lo: $$(H_make_S_module_path)/$(1)/%.c \
$$(addprefix $$(H_make_S_compile_path)/,E_cplus_S_machine.h E_cplus_S_language.h $$(H_make_S_compiler_cx_sources)) \
$$(H_make_S_module_path)/E_cplus_S_0_to_libs.h \
$$(foreach module,$$(H_make_S_modules),$$(addprefix $$(H_make_S_module_path)/$$(module)/,0.mak 0.h $$(patsubst %.cx,E_cplus_S_0_%.h,$$(notdir $$(wildcard $$(H_make_S_module_path)/$$(module)/*.cx))) $$(patsubst %.cx,E_cplus_S_1_%.h,$$(notdir $$(wildcard $$(H_make_S_module_path)/$$(module)/*.cx))) $$(patsubst %.cx,E_cplus_S_2_%.h,$$(notdir $$(wildcard $$(H_make_S_module_path)/$$(module)/*.cx)))))
	$$(LIBTOOL) --quiet --mode=compile --tag=CC $$(CC) $$(call H_make_Q_packages_R_cflags,$$(E_module_S_packages)) $$(CFLAGS) $$(TARGET_ARCH) -shared -prefer-pic -c -iquote$$(call H_make_Z_shell_cmd_arg_I_quote,$$(H_make_S_compile_path)) -iquote$$(call H_make_Z_shell_cmd_arg_I_quote,$$(H_make_S_module_path)) -include E_cplus_S_0_to_libs.h $$(addprefix -include ,$$(call H_make_Z_shell_cmd_arg_I_quote_for,$$(H_make_S_compiler_cx_sources))) $$(call H_make_Z_shell_cmd_arg_I_quote,$$<) -o $$(call H_make_Z_shell_cmd_arg_I_quote,$$@)
$$(H_make_S_module_path)/$(1)/lib$$(H_make_S_lib_prefix)$(1).so: $$(patsubst %.cx,%.lo,$$(wildcard $$(H_make_S_module_path)/$(1)/*.cx))
	$$(LIBTOOL) --quiet --mode=link --tag=CC $$(CC) $$(call H_make_Q_packages_R_cflags,$$(E_module_S_packages)) $$(CFLAGS) $$(call H_make_Q_packages_R_ldflags,$$(E_$(2)_S_packages)) $$(LDFLAGS) $$(TARGET_ARCH) -s -shared -fPIC -Wc,-shared -Wc,-fPIC $$(call H_make_Z_shell_cmd_arg_I_quote_for,$$^) -o $$(call H_make_Z_shell_cmd_arg_I_quote,$$@) $$(addprefix -l,$$(call H_make_Z_shell_cmd_arg_I_quote_for,$$(E_$(2)_S_libraries))) $$(call H_make_Q_packages_R_ldlibs,$$(E_$(2)_S_packages))
        endef

$(foreach module,$(H_make_S_modules),$(eval $(call H_make_Q_lib_M,$(module),$(call H_make_Z_list_I_index,$(module),$(H_make_S_modules)))))
        undefine H_make_Q_lib_M

a.out: \
0.mak E_cplus_S_0_main_not_to_libs.h 0.h \
$(patsubst %.cx,E_cplus_S_0_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,E_cplus_S_1_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,E_cplus_S_2_%.h,$(H_make_S_cx_sources)) \
$(patsubst %.cx,%.c,$(H_make_S_cx_sources)) \
$(foreach module,$(H_make_S_modules),$(H_make_S_module_path)/$(module)/lib$(H_make_S_lib_prefix)$(module).so)
	$(CC) $(call H_make_Q_packages_R_cflags,$(sort $(E_module_S_packages) $(E_main_S_packages))) $(CFLAGS) $(call H_make_Q_packages_R_ldflags,$(E_main_S_packages)) $(LDFLAGS) $(TARGET_ARCH) -fPIE -pie -s -iquote$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_compile_path)) -iquote$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)) -include E_cplus_S_0_main_not_to_libs.h $(addprefix -include ,$(call H_make_Z_shell_cmd_arg_I_quote_for,$(H_make_S_compiler_cx_sources))) $(call H_make_Z_shell_cmd_arg_I_quote_for,$(filter %.c,$^)) -o $(call H_make_Z_shell_cmd_arg_I_quote,$@) $(foreach module,$(H_make_S_modules),-L$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module))) $(foreach module,$(H_make_S_modules),-l$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_lib_prefix)$(module))) $(addprefix -l,$(call H_make_Z_shell_cmd_arg_I_quote_for,$(E_main_S_libraries))) $(call H_make_Q_packages_R_ldlibs,$(E_main_S_packages))

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
    endif

clean: mostlyclean
    ifneq (,$(H_make_C_to_libs))
	$(call H_make_I_libtool_I_clean,$(foreach module,$(H_make_S_modules),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,%.lo,$(wildcard $(H_make_S_module_path)/$(module)/*.cx)))),$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(H_make_S_base_module)/$(H_make_S_base_driver).lo),$(foreach module,$(H_make_S_modules),$(addprefix $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module)/.libs/),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,%.o,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx)))))) $(foreach module,$(H_make_S_modules),$(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module)/.libs)))
    endif

distclean: clean
	$(RM) $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/E_cplus_S_0_to_libs.h) E_cplus_S_0_main_not_to_libs.h \
      $(H_make_S_module_path)/E_cplus_S_cx_sources E_cplus_S_cx_sources \
      $(foreach module,$(H_make_S_modules),$(addprefix $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module)/),$(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,E_cplus_S_0_%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))) $(patsubst %.cx,E_cplus_S_1_%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))) $(patsubst %.cx,E_cplus_S_2_%.h,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx))) $(patsubst %.cx,%.c,$(notdir $(wildcard $(H_make_S_module_path)/$(module)/*.cx)))))) \
      $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/E_cplus_S_0_to_libs.h) \
      $(call H_make_Z_shell_cmd_arg_I_quote_for,$(patsubst %.cx,E_cplus_S_0_%.h,$(H_make_S_cx_sources)) $(patsubst %.cx,E_cplus_S_1_%.h,$(H_make_S_cx_sources)) $(patsubst %.cx,E_cplus_S_2_%.h,$(H_make_S_cx_sources)) $(patsubst %.cx,%.c,$(H_make_S_cx_sources))) \
      $(H_make_S_compile_path)/headers-db
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Uruchamianie rezultatu nie zainstalowanego.
run: build
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
    ./a.out "$$@"' ;\
    if [ -n "$$( which ocq 2>/dev/null )" ]; then \
        ocq term-args "$$cmd" "$$SHELL" "$$PWD" $(if $(H_make_C_to_libs),"$$libs") $(call H_make_Z_shell_cmd_arg_I_quote_for,$(S_cmd_arg)) ;\
    elif [ -n "$$( which xterm 2>/dev/null )" ]; then \
        xterm -maximized -e "$$SHELL" -c "$$cmd" "$$SHELL" "$$PWD" $(if $(H_make_C_to_libs),"$$libs") $(call H_make_Z_shell_cmd_arg_I_quote_for,$(S_cmd_arg)) ;\
    else \
        $(if $(H_make_C_to_libs), LD_LIBRARY_PATH="$$libs" \
          $(if $(H_make_C_to_libs_C_replace_c_alloc) \
          , LD_PRELOAD=lib$(H_make_S_lib_prefix)$(H_make_S_base_module).so)) \
        ./a.out $(call H_make_Z_shell_cmd_arg_I_quote_for,$(S_cmd_arg)) ;\
    fi
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
install-0:
	tmp_file=$$( mktemp ) ;\
	trap '$(RM) "$$tmp_file"' EXIT ;\
	{ echo '#!/bin/sh' ;\
	$(if $(H_make_C_to_libs_C_replace_c_alloc),echo 'exec env LD_PRELOAD=liboux-base.so "$$@"',echo 'exec "$$@"'); } > "$$tmp_file" ;\
	{ $(CMP) "$$tmp_file" /usr/bin/oux \
	|| $(INSTALL) -m 755 "$$tmp_file" /usr/bin/oux; \
	} \
	&& { $(CMP) $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_root_path)/direct-oux) /usr/bin/direct-oux \
	|| $(INSTALL) -m 755 $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_root_path)/direct-oux) /usr/bin/direct-oux; \
	} \
	$(if $(H_make_C_to_libs),$(foreach module,$(H_make_S_modules), && { $(CMP) $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module)/lib$(H_make_S_lib_prefix)$(module).so) $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_usr_lib)/lib$(H_make_S_lib_prefix)$(module).so) \
        || $(INSTALL) -m 755 $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_module_path)/$(module)/lib$(H_make_S_lib_prefix)$(module).so) $(call H_make_Z_shell_cmd_arg_I_quote,$(H_make_S_usr_lib)/lib$(H_make_S_lib_prefix)$(module).so); \
        } \
    ))
#-------------------------------------------------------------------------------
uninstall-0:
	$(RM) $(H_make_S_usr_lib)/lib$(H_make_S_lib_prefix)*.so
################################################################################
