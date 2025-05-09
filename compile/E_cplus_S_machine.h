/*******************************************************************************
*   ___   publicplace
*  ¦OUX¦  ‟C+” into ‟C”
*  ¦/C+¦  compile
*   ---   C+
*         platform definitions
* ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒1‒6 *
*******************************************************************************/
    #if !( defined( __gnu_linux__ ) || defined( __FreeBSD__ ) || defined( __NetBSD__ ) || defined( __OpenBSD__ ))
#error Unknown operating system
    #endif
//==============================================================================
    #if defined( __gnu_linux__ )
        #ifndef MAP_UNINITIALIZED
#define MAP_UNINITIALIZED 0
        #endif
        #ifndef E_io_C_aio
#define E_io_Q_stream_out_C_sig
#define E_io_C_sig_has_fd
        #endif
    #elif defined( __OpenBSD__ )
#define E_flow_Q_process_call_C_alt
    #endif
//------------------------------------------------------------------------------
    #ifdef E_flow_drv_C_clock_monotonic
        #ifdef __gnu_linux__
            #if defined( _POSIX_C_SOURCE ) && _POSIX_C_SOURCE >= 199309L
#define E_flow_drv_C_timer_monotonic
            #else
#warning "E_flow_drv_C_clock_monotonic" unavailable
            #endif
        #endif
    #endif
//==============================================================================
// Włącza wypisywanie ‹raportów linii› umieszczonych instrukcjami “G”[…] lub z błędów w instrukcjach “V”[…]. Wyłączenie ‹raportów linii› nie wyłącza “strumienia” wypisywania dostępnego programowo.
#define C_line_report
// Przełącza na jeszcze mniejszy rozmiar identyfikatorów.
#define C_id_small
// Przechowuje adres “errno” zamiast za każdym razem używać makra “errno”, które wywołuje procedurę podającą ten adres. Wyjście poza standard implementacji ‟C”, ale działa, a optymalizuje program.
#define E_flow_C_errno_p
//==============================================================================
// Podejście ‘asemblerowe’ wysokiego poziomu.
// Nadzwyczajne typy danych:
typedef unsigned char       N8;
typedef signed char         S8;
typedef unsigned short      N16;
typedef short               S16;
    #if defined( __i386__ )
typedef unsigned long       N32;
typedef long                S32;
typedef unsigned long long  N64;
typedef long long           S64;
    #elif defined( __x86_64__ )
typedef unsigned            N32;
typedef int                 S32;
typedef unsigned long       N64;
typedef long                S64;
        #ifdef __SSE__
typedef unsigned __int128   N128;
typedef __int128            S128;
        #endif
    #endif
//------------------------------------------------------------------------------
// Podstawowe typy danych:
typedef _Bool               B; // Musi być: “true == 1”.
typedef char                C; // Bajt lub znak bajtowy. Nieprzekraczalne reguły konwersji domyślnej w ‟C” z “char” do “int” wymuszają deklarację “char” bez podania “signed” lub “unsigned”, i następnie w pojedynczych przypadkach domyślnej zmiany z wielkości bajtowej– jawną konwersję typów, przez “unsigned char”. Sposób masowej realizacji takiej konwersji nie jest jeszcze ustalony.
     #if defined( __i386__ )
typedef N32                 N;
typedef S32                 S;
typedef S16                 I;
    #elif defined( __x86_64__ )
typedef N64                 N; // Liczba naturalna do obliczeń arytmetycznych.
typedef S64                 S; // Ta sama liczba jak powyżej, ale ze znakiem. Ponieważ jest deklarowana jako maksymalna (“long”), to podlega zawsze domyślnej konwersji z nieistniejącym obcięciem wartości bitowej w obszarze maksymalnych wartości pojedynczych (nie tych scalanych w obliczeniach przez “carry flag”) liczb naturalnych maszyny.
        #ifdef C_id_small
typedef S16                 I; // ‹Identyfikator› tylko danych zarządzanych przez ‹menedżerów› ‟oux” (a nie przez zewnętrzne, dołączane podsystemy).
        #else
typedef N32                 I;
        #endif
    #endif
typedef unsigned            In; // Służy do konwersji wartości “I” podczas porównywania.
typedef N32                 U; // Znak ‘unicode’.
typedef double              F; // Podstawowa liczba zmiennoprzecinkowa maszyny, ale do stosowania tylko w obliczeniach, w których wartość zbierająca niedokładność obliczeń jest urealniania w poszczególnych krokach programu.
typedef void                *P; // Tylko do deklaracji parametrów i konwersji pomiędzy typami wskaźnikowymi (nadawania przetwarzanej zawartości danych wskazywanych).
//==============================================================================
#define E_mem_Q_file_S_filename_separator   '/'
#define E_mem_Q_file_S_filename_separator_s "/"
/******************************************************************************/
