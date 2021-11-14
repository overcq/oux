/*******************************************************************************
*   ___   publicplace
*  ¦OUX¦  ‟C+” into ‟C”
*  ¦/C+¦  compile
*   ---   C+
*         base definitions
* ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒1‒6 *
*******************************************************************************/
// “Statement” i wyrażenia rozszerzonej składni, które muszą znajdować się w nawiasach klamrowych bloku nadrzędnego: “for_”[…], “V”[…], linie “G”[…].
// Ogólne standardy ‘interfejsów’ ‹procedur›:
// ‣ dodatkowe wyniki ‹procedur› są przypisywane zmiennym wskaźnikowym, jeśli podany adres zmiennej nie jest zerowy.
// ‣ ‹menedżer› mogący zmienić adres przechowywany w zmiennej uchwytu obiektu otrzymuje jako pierwszy ‘argument’ wskaźnik do zmiennej uchwytu, którą uaktualnia, jeśli potrzeba. Takimi ‹menedżerami› są tylko wydający adres struktury danych: ⁃“mem_blk” musi tak robić, ale ma zarejestrowane wszystkie wydane adresy, ⁃“mem_tab” nie musi tak robić, lecz dla oszczędności nie rejestruje wydanych tablic, a zawsze można to zmienić w przyszłości. Poza ‹menedżerami› pamięci raczej nic więcej nie potrzebuje wydawać jako uchwyt obiektu— adresu struktury danych opisu, lecz ‹identyfikator› obiektu.
//==============================================================================
typedef C           *Pc; // Wskaźnik do obliczeń bajtowych i tekst techniczny języka ‟C” lub ‘UTF-8’. zawsze będzie równoważny “char *” (przy uzgadnianiu ‘interfejsów’ procedur systemu operacyjnego).
typedef N           *Pn; // Wskaźnik do tablic liczb naturalnych.
typedef P           *Pp; // Wskaźnik do tablic adresów.
//==============================================================================
#define no                                  false
#define yes                                 true
// Wyrażenie przypisania automatycznie nadające podanej wartości rozmiar zmiennej. Naprawia konieczność jawnego deklarowania przyrostków dla typów stałych; bo domyślnie “int”.
#define _v(a,v)                             (( (a) ^ (a) ) | (v) )
//------------------------------------------------------------------------------
#define _J_s(a)                             #a
#define J_s(a)                              _J_s(a)
#define _J_ab(a,b)                          a##b
#define J_ab(a,b)                           _J_ab(a,b)
#define J_a_b(a,b)                          J_ab(J_ab(a,_),b)
//------------------------------------------------------------------------------
#define J_n_10_max_digits(l)                ( l == 8 ? 20 : l == 4 ? 10 : l == 2 ? 5 : 3 )
#define J_swap(type,a,b)                    { type J_autogen(_) = a; a = b; b = J_autogen(_); }
#define J_min(a,b)                          ( (a) > (b) ? (b) : (a) )
#define J_max(a,b)                          ( (a) < (b) ? (b) : (a) )
#define J_abs(v)                            ( (S)(v) < 0 ? -(v) : (v) )
//------------------------------------------------------------------------------
#define J_autogen_S                         _autogen
#define J_autogen(a)                        J_a_b( a, J_autogen_S )
#define J_autogen_line(a)                   J_autogen( J_a_b( a, __LINE__ ))
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#define O                                   while(yes)
#define for_n_(i_var,n)                     for( i_var = 0; i_var != (n); i_var++ )
#define for_n(i_var,n)                      N i_var; for_n_(i_var,(n))
#define for_n_rev_(i_var,n)                 i_var = (n); while( i_var-- )
#define for_n_rev(i_var,n)                  N for_n_rev_(i_var,(n))
#define for_i_(i_var,n)                     for_n_(i_var,(n))
#define for_i(i_var,n)                      I i_var; for_i_(i_var,(n))
#define for_i_rev_(i_var,n)                 for_n_rev_(i_var,(n))
#define for_i_rev(i_var,n)                  I for_i_rev_(i_var,(n))
//------------------------------------------------------------------------------
#define for_each_out_(out,id_var,p,q)       id_var = (out); while( ~( id_var = J_a_b(q,Z_iter_R_next)( (p), id_var, (out) )))
#define for_each_out(out,id_var,p,q)        I for_each_out_(out,id_var,(p),q)
#define for_each_(id_var,p,q)               for_each_out_(~0,id_var,(p),q)
#define for_each(id_var,p,q)                for_each_out(~0,id_var,(p),q)
//------------------------------------------------------------------------------
#define for_each_rev_out_(out,id_var,p,q)   id_var = (out); while( ~( id_var = J_a_b(q,Z_iter_R_prev)( (p), id_var, (out) )))
#define for_each_rev_out(out,id_var,p,q)    I for_each_rev_out_(out,id_var,(p),q)
#define for_each_rev_(id_var,p,q)           for_each_rev_out_(~0,id_var,(p),q)
#define for_each_rev(id_var,p,q)            for_each_rev_out(~0,id_var,(p),q)
//------------------------------------------------------------------------------
#define for_each_pop_out_(out,id_var,p,q) \
  for( \
  ; ~( id_var = J_a_b(q,Z_iter_R_prev)( (p), ~0, (out) )) \
  ; E_mem_Q_tab_I_remove( (p), id_var ) \
  )
#define for_each_pop_out(out,id_var,p,q)    I id_var; for_each_pop_out_((out),id_var,(p),q)
#define for_each_pop_(id_var,p,q)           for_each_pop_out_(~0,id_var,(p),q)
#define for_each_pop(id_var,p,q)            I id_var; for_each_pop_(id_var,(p),q)
//------------------------------------------------------------------------------
#define for_each_q_out(out,id_var,p,iter,q) \
  I id_var; \
  I J_autogen_line(id_var) = (out); \
  while(( id_var = J_a_b(q,Q_iter_R_next)( (p), (iter), ++J_autogen_line(id_var) )) != (out) )
#define for_each_q(id_var,p,iter,q)         for_each_q_out(~0,id_var,(p),(iter),q)
//==============================================================================
#define _F_uid_v(v)                         ( (v) << ( sizeof(int) * 8 / 2 ))
#define _F_uid(file_identifier)             J_autogen(J_a_b(F,file_identifier))
#define _K_proc(module,event)               J_a_b(J_a_b(E,module),J_a_b(K,event))
#define _XhYi_F_uid(file_identifier)        _F_uid_v( _F_uid(file_identifier) )
#define _XhYi_uid(module,report_impulser)   J_autogen(J_a_b(J_a_b(E,module),report_impulser))
#define _X_uid(module,report)               J_autogen(J_a_b(J_a_b(E,module),J_a_b(X,report)))
#define _X_var(module,report)               J_autogen(J_a_b(J_a_b(E,module),J_a_b(J_a_b(X,report),S)))
#define _Yi_uid(module,impulser)            J_autogen(J_a_b(J_a_b(E,module),J_a_b(Yi,impulser)))
#define _Yi_var(module,impulser)            J_autogen(J_a_b(J_a_b(E,module),J_a_b(J_a_b(Yi,impulser),S)))
#define _D_proc(module,task)                J_a_b(J_a_b(E,module),J_a_b(D,task))
#define D_id(module,task)                   J_autogen(J_a_b(J_a_b(E,module),J_a_b(J_a_b(D,task),S)))
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//#define Q_use(variable,object,...)    if( ~(( variable ) = J_a_b(object,D_M)( __VA_ARGS__ ))) {
//#define Q_use_0(variable,object,...)  if(( variable ) = J_a_b(object,D_M)( __VA_ARGS__ )) {
//#define Q_rel(object,...)         J_a_b(object,D_W)( __VA_ARGS__ ); }else { K( "Q_use" ); }
//------------------------------------------------------------------------------
#define _0(pointer_variable,l)              E_mem_Q_blk_P_fill_c( (pointer_variable), l, 0 )
#define _0_(pointer_variable)               _0( (pointer_variable), sizeof( *(pointer_variable) ))
//------------------------------------------------------------------------------
// Utworzenie i wyrzucenie zmiennej w pamięci ‘alokowanej’ w “menedżerze pamięci”.
#define M(l)                                E_mem_Q_blk_M(l)
#define Mt(u,n)                             E_mem_Q_blk_M_tab((u),(n))
#define W(pointer_variable)                 E_mem_Q_blk_W( pointer_variable )
#define M_(pointer_variable)                pointer_variable = M( sizeof( *( pointer_variable )))
#define Mt_(pointer_variable,n)             pointer_variable = Mt( sizeof( *( pointer_variable )), (n) )
#define W_(pointer_variable)                ( W( pointer_variable ), pointer_variable = 0 )
#define W_tab_(pointer_variable)            ( E_mem_Q_tab_W( pointer_variable ), pointer_variable = 0 )
//------------------------------------------------------------------------------
// Instrukcja blokowa definicji ‹zadania›.
#define D(module,task)                      _internal void _D_proc(module,task)( P thread_proc_arg )
// Instrukcja blokowa pętli głównej ‹zadania›.
#define I_D                                 if( E_flow_Q_task_I_begin() ){} else O
//------------------------------------------------------------------------------
// Utworzenie i wyrzucenie ‹zadania› lub ‹zadania› “wątkowanego” czekającego na ‹systemowy raport odblokowujący›.
    #ifndef E_flow_C_thread_system_unblock_reports
#define Dh_()
        #ifdef C_line_report
#define D_M(module,task)                    if( ~E_flow_Q_task_M( &(D_id(module,task)), _D_proc(module,task), J_s( _D_proc(module,task) ))){} else
        #else
#define D_M(module,task)                    if( ~E_flow_Q_task_M( &(D_id(module,task)), _D_proc(module,task) )){} else
        #endif
    #else
        #if defined( __gnu_linux__ )
#define Dh_()                               _unused int *E_flow_S_errno = __errno_location()
        #elif defined( __OpenBSD__ )
#define Dh_()                               _unused int *E_flow_S_errno = __errno()
        #endif
//TODO Rozdzielić dla “Dh”— na ‹zadania› takie jak “D” (bez “subid”) oraz takie jak obecnie “Dh” (“Dhi”).
        #ifdef C_line_report
#define D_M(module,task)                    if( ~E_flow_Q_task_M( &(D_id(module,task)), _D_proc(module,task), 0, no, J_s( _D_proc(module,task) ))){} else
#define Dh_M(module,task,subid,arg)         if( ~E_flow_Q_task_M_thread( &(D_id(module,task)), (subid), _D_proc(module,task), (arg), J_s( _D_proc(module,task) ))){} else
        #else
#define D_M(module,task)                    if( ~E_flow_Q_task_M( &(D_id(module,task)), _D_proc(module,task), 0, no )){} else
#define Dh_M(module,task,subid,arg)         if( ~E_flow_Q_task_M_thread( &(D_id(module,task)), (subid), _D_proc(module,task), (arg) )){} else
        #endif
#define Dh_W(module,task,subid)             E_flow_Q_task_W_thread( &(D_id(module,task)), (subid) )
    #endif
#define D_W(module,task)                    E_flow_Q_task_W( &(D_id(module,task)) )
//------------------------------------------------------------------------------
// Znacznik stanu —zwykle stanu pojedynczego obiektu sygnalizującego później kolekcję— umieszczony w strukturze tego ‹obiektu› dostępnej przez wyrażenie.
#define U_R(start_expr,state_name)          J_a_b(start_expr,J_autogen(J_a_b(U,state_name)))
// Wzbudzenie stanu.
#define U_F(start_expr,state_name)          U_R(start_expr,state_name) = yes
// I liniowe obsłużenie tego stanu.
#define U_L(start_expr,state_name)          U_R(start_expr,state_name) = no
// Albo blokowe.
#define U_E(start_expr,state_name)          ( U_R(start_expr,state_name) && ( U_L(start_expr,state_name), yes ))
//------------------------------------------------------------------------------
// Instrukcja blokowa definicji ‹zdarzenia›.
#define K(module,event)                     B _K_proc(module,event)( I object )
// Deklaracja emisji ‹zdarzenia›.
#define K_E(module,event,object)            if( !_K_proc(module,event)(object) ){} else
//------------------------------------------------------------------------------
// Instrukcje “X_M”/“X_A”, “Yi_M”/“Yi_A” muszą występować w jednym z najwyższych bloków struktury programu ‹zadania›, w miejscu zapewniającym taką widoczność (do użycia ‹raportu› w tym ‹zadaniu›) jak deklaracja zmiennej lokalnej.
// Utworzenie i wyrzucenie ‹raportu›.
#define X_M_(module,report)                 _X_var(module,report) = E_flow_Q_report_M( _X_uid(module,report) )
#define X_M(module,report)                  I X_M_(module,report)
#define X_W(module,report)                  E_flow_Q_report_W( _X_var(module,report) )
// Deklaracja emisji ‹raportu› przez ‹zadanie›.
#define X_A(module,report)                  X_M(module,report); _unused B U_L(module,report)
// Sygnalizacja ‹zadania› obsługującego ‹raport› kolekcji.
#define X_F(module,report)                  E_flow_Q_report_I_signal( _X_var(module,report) )
// I warunkowa– gdy jest stan pojedynczego obiektu.
#define X_U(module,report)                  if( !U_E(module,report) ){} else X_F(module,report)
// Czekanie na ‹raport› kolekcji.
#define X_B(module,report,lost_count)       if( !E_flow_Q_report_I_wait( _X_var(module,report), (lost_count) )){} else
//------------------------------------------------------------------------------
    #ifdef E_flow_C_thread_system_unblock_reports
// Deklaracja ‹procedury› generującej ‹systemowy raport odblokowujący› dla ‹zadania›; odblokowującej to ‹zadanie›.
#define Xh_A( thread_unblock_proc_ ) \
  pthread_mutex_t *J_autogen( thread_flow_mutex ); \
  B *J_autogen( thread_switch_back ); \
  E_flow_Q_thread_system_unblock_report_M(( thread_unblock_proc_ ), &J_autogen( thread_flow_mutex ), &J_autogen( thread_switch_back ))
// Tuż przed wywołaniem procedury blokującej w oczekiwaniu na ‹systemowy raport odblokowujący›.
#define Xh_B_() \
  *J_autogen( thread_switch_back ) = yes; \
  E_flow_Q_thread_system_unblock_report_I_before_block( J_autogen( thread_flow_mutex ))
// Czekanie na ‹systemowy raport odblokowujący›; tuż po wywołaniu procedury blokującej.
#define Xh_B() \
  *J_autogen( thread_switch_back ) = no; \
  if( !E_flow_Q_thread_system_unblock_report_I_after_block( J_autogen( thread_flow_mutex ))){} else
    #else
#define Xh_A( thread_unblock_proc_ )
    #endif
//------------------------------------------------------------------------------
    #ifdef E_flow_C_itimer_system_unblock_report
// Utworzenie i wyrzucenie ‹systemowego raportu odblokowującego› typu “itimer”, występującego najwyżej jeden raz.
#define Xh1_M(sigsuspend,setitimer)         E_flow_Q_itimer_system_unblock_report_M( sigsuspend, setitimer )
#define Xh1_W()                             E_flow_Q_itimer_system_unblock_report_W()
// Czekanie na ‹systemowy raport odblokowujący› typu “itimer”.
#define Xh1_B()                             if( !E_flow_Q_itimer_system_unblock_report_I_wait() ){} else
    #endif
//------------------------------------------------------------------------------
// Utworzenie i wyrzucenie ‹cyklera›.
#define Y_M(period)                         E_flow_Q_timer_M(period)
#define Y_W(timer)                          E_flow_Q_timer_W(timer)
// Czekanie na pełny okres ‹cyklera›.
#define Y_B(timer,lost_count)               if( !E_flow_Q_timer_I_wait( (timer), (lost_count) )){} else
//------------------------------------------------------------------------------
// Utworzenie i wyrzucenie ‹impulsatora›.
#define Yi_M(module,impulser)               I _Yi_var(module,impulser) = E_flow_Q_impulser_M( _Yi_uid(module,impulser) )
#define Yi_W(module,impulser)               E_flow_Q_timer_W( _Yi_var(module,impulser) )
// Deklaracja aktywacji ‹impulsatora› przez ‹zadanie›.
#define Yi_A(module,impulser)               I _Yi_var(module,impulser) = E_flow_Q_impulser_M_srv( _Yi_uid(module,impulser) )
// Aktywacja ‹impulsatora›.
#define Yi_F(module,impulser,time)          E_flow_Q_impulser_I_activate( _Yi_var(module,impulser), (time) )
// Dezaktywacja ‹impulsatora›.
#define Yi_L(module,impulser)               E_flow_Q_impulser_I_deactivate( _Yi_var(module,impulser) )
// Czekanie na wzbudzenie przez ‹impulsator›.
#define Yi_B(module,impulser)               if( !E_flow_Q_impulser_I_wait( _Yi_var(module,impulser) )){} else
//------------------------------------------------------------------------------
// Czekanie na wznowienie w następnym obiegu czasu.
#define I_B()                               if( !E_flow_Q_task_I_schedule() ){} else
//------------------------------------------------------------------------------
// Wyjście z ‹zadania› po procedurze zawierającej instrukcję przełączenia.
#define I_V()                               if( !E_flow_Q_task_R_exit() ){} else
//==============================================================================
#define _G_var      J_autogen_line(G)
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #ifdef C_line_report
//TODO W przyszłości zastąpić niegwarantowane wypisywanie synchroniczne na wypisywanie do specjalnego wyjścia danych, zawsze dostępnego, a niekoniecznie o dużej pojemności.
// ‹Raport linii› nie wymagający integralności programu. w miejscach, gdzie nie można wykonywać funkcji wypisywania integralnej tego programu. ponieważ nie można wywoływać żadnej funkcji obiektowości zarządzanej albo takiej funkcji może użyć funkcja żądania wypisania integralna tego programu.
#define G_()        _unused B _G_var = yes; E_flow_Z_line_report_Z_line_I_sync( &__FILE__[0], __LINE__, 0 )
// ‹Raport linii›.
#define G()         _unused B _G_var = no; E_flow_Z_line_report_Z_line_I( &__FILE__[0], __LINE__, 0 )
// ‹Niepowodzenie zakańczające› (ewentualną instrukcją “V” umieszczoną na końcu linii). zaistniałe przez wejście na tę linię tekstu programu.
#define GV_(s)      _unused B _G_var = yes; E_flow_Z_line_report_Z_line_I_sync( &__FILE__[0], __LINE__, J_s(s) )
// ‹Niepowodzenie ostrzegające› (bez instrukcji “V”). 〃
#define GV(s)       _unused B _G_var = no; E_flow_Z_line_report_Z_line_I( &__FILE__[0], __LINE__, J_s(s) )
//------------------------------------------------------------------------------
// Wypisywanie zmiennych programu; po “G”/“GV”/“G_”/“GV_” w linii.
#define Gc(c)       if( _G_var ) E_flow_Z_line_report_Z_text_c_I_sync( J_s(c), c ); else E_flow_Z_line_report_Z_text_c_I( J_s(c), c )
#define Gs(s,s_end) if( (s_end) - (s) ) Gs_l( s, s, (s_end) - (s) ); else Gs_l( s, "", 0 )
#define Gs_(s,s_end) if( (s_end) - (s) ) Gs_l_( s, (s_end) - (s) ); else Gs_l_( "", 0 )
#define Gs0(s)      Gs_l( s, s, 0 )
#define Gs0_(s)     Gs_l_( s, 0 )
#define Gsl(s,l)    if(l) Gs_l( s, s, (l) ); else Gs_l( s, "", 0 )
#define Gsl_(s,l)   if(l) Gs_l_( s, (l) ); else Gs_l_( "", 0 )
#define Gs_l(t,s,l) if( _G_var ) E_flow_Z_line_report_Z_text_s_I_sync( J_s(t), (s), (l) ); else E_flow_Z_line_report_Z_text_s_I( J_s(t), (s), (l) )
#define Gs_l_(s,l)  if( _G_var ) E_flow_Z_line_report_Z_s_I_sync( (s), (l) ); else E_flow_Z_line_report_Z_s_I( (s), (l) )
#define Gd(n)       if( _G_var ) E_flow_Z_line_report_Z_text_n_I_sync( J_s(n), (N)(n), sizeof(n), 10 ); else E_flow_Z_line_report_Z_text_n_I( J_s(n), (N)(n), sizeof(n), 10 )
#define Gh(n)       if( _G_var ) E_flow_Z_line_report_Z_text_n_I_sync( J_s(n), (N)(n), sizeof(n), 16 ); else E_flow_Z_line_report_Z_text_n_I( J_s(n), (N)(n), sizeof(n), 16 )
#define Gq(q)
    #else
#define G()
#define G_()
#define GV(s)
#define GV_(s)
#define Gc(c)
#define Gs(s,s_end)
#define Gs_(s,s_end)
#define Gs0(s)
#define Gs0_(s)
#define Gs_l(s)
#define Gs_l_(s)
#define Gd(n)
#define Gh(n)
#define Gq(q)
    #endif
//------------------------------------------------------------------------------
#define V()         _exit( EXIT_FAILURE )
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//NDFN Zintegrować koncepcje “V” razem z “K”. i wtedy zostanie dołączona koncepcja procesów ‘restartowalnych’ ze stanu zachowanego w momencie wystąpienia takiego błędu (a nie zachowywanego ciągle).
//NKN “V” są drogami wyjścia po nieudanym “K” wewnętrznym funkcji wołanej.
// W instrukcjach “V”[…]“e” w przypadku braku błędu podanego “statement” podana zmienna “e” ma nie zmienioną wartość.
// ‹Nierealizacje zakańczające› (“V”[…]“_”) powinny być stosowane dla procedur systemu operacyjnego, które muszą się udać dla kontynuacji jakiegokolwiek przepływu wykonania, oraz dla zwalniania oczywistych zasobów.
#define _V_(statement)                      _V(statement) V()
#define _VO_(statement)                     _VO(statement) V()
//------------------------------------------------------------------------------
#define Vr_(statement)                      Vr(statement) V()
#define Vr1_(statement)                     Vr1(statement) V()
#define Vr_1_(statement)                    Vr_1(statement) V()
//------------------------------------------------------------------------------
#define Vp_(statement)                      _V_(statement)
#define VOp_(statement)                     _VO_(statement)
//------------------------------------------------------------------------------
#define V0_(statement)                      _V_(!(statement))
#define VO0_(statement)                     _VO_(!(statement))
//------------------------------------------------------------------------------
#define V1_(statement)                      _V_(~(statement))
#define VO1_(statement)                     _VO_(~(statement))
//------------------------------------------------------------------------------
#define V1p_(statement)                     _V_(~(N)(statement))
#define VO1p_(statement)                    _VO_(~(N)(statement))
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//NKN ‹Nierealizacje blokowe› (“V”[…]), które wystąpiły w ‹zadaniu› innym niż “main”, muszą być obsługiwane przez zablokowanie się ‹zadania› na linii wyjścia z “I_D” i sygnalizację błędu (pół‐‹zdarzenie›?), by ‹zadanie›, które je uruchomiło (co najmniej “main” usuwające pośrednio wszystkie ‹zadania› i kończące program), mogło normalnie je usunąć. Wtedy nie będzie już nigdy krytycznego (przez zgubienie danych i bytów sterowanych) przerywania programu z powodu błędu procedury systemu operacyjnego oprócz sytuacji, gdy lepiej będzie natychmiast przerwać program niż jeszcze coś rozwalić z jego uszkodzonego wewnętrznego stanu.
    #ifdef C_line_report
#define Vr(statement) \
  int J_autogen_line(e) = (statement); \
  if( !J_autogen_line(e) || ( _errno = J_autogen_line(e), E_flow_Z_line_report_Z_line_I_error( &__FILE__[0], __LINE__ ), no )) \
  { \
  }else
#define Vr1(statement) \
  int J_autogen_line(e) = (statement); \
  if( J_autogen_line(e) <= 0 || ( _errno = J_autogen_line(e), E_flow_Z_line_report_Z_line_I_error( &__FILE__[0], __LINE__ ), no )) \
  { \
  }else
#define Vr_1(statement) \
  int J_autogen_line(e) = (statement); \
  if( J_autogen_line(e) >= 0 || ( _errno = -J_autogen_line(e), E_flow_Z_line_report_Z_line_I_error( &__FILE__[0], __LINE__ ), no )) \
  { \
  }else
#define _Ve(statement,e) \
  if( _errno = 0, (statement) || ( e = _errno, E_flow_Z_line_report_Z_line_I_error( &__FILE__[0], __LINE__ ), no )) \
  { \
  }else
#define _VOe(statement,e) \
  J_autogen_line(Loop): \
  if( _errno = 0, (statement) || ( e = _errno, no )) \
  { \
  }else if( e == EINTR || ( E_flow_Z_line_report_Z_line_I_error( &__FILE__[0], __LINE__ ), no )) \
      goto J_autogen_line(Loop); \
  else
    #else
#define Vr(statement) \
  if( !(statement) ) \
  { \
  }else
#define Vr1(statement) \
  if( (statement) <= 0 ) \
  { \
  }else
#define Vr_1(statement) \
  if( (statement) >= 0 ) \
  { \
  }else
#define _Ve(statement,e) \
  if( _errno = 0, (statement) || ( e = _errno, no )) \
  { \
  }else
#define _VOe(statement,e) \
  J_autogen_line(Loop): \
  if( _errno = 0, (statement) || ( e = _errno, no )) \
  { \
  }else if( e == EINTR ) \
      goto J_autogen_line(Loop); \
  else
    #endif
//------------------------------------------------------------------------------
#define _V(statement) \
  _unused int J_autogen_line(e); \
  _Ve( (statement), J_autogen_line(e) )
#define _VO(statement) \
  _unused int J_autogen_line(e); \
  _VOe( (statement), J_autogen_line(e) )
//------------------------------------------------------------------------------
#define Vpe(statement,e)                    _Ve((statement),e)
#define Vp(statement)                       _V(statement)
#define VOpe(statement,e)                   _VOe((statement),e)
#define VOp(statement)                      _VO(statement)
//------------------------------------------------------------------------------
#define V0e(statement,e)                    _Ve(!(statement),e)
#define V0(statement)                       _V(!(statement))
#define VO0e(statement,e)                   _VOe(!(statement),e)
#define VO0(statement)                      _VO(!(statement))
//------------------------------------------------------------------------------
#define V1e(statement,e)                    _Ve(~(statement),e)
#define V1(statement)                       _V(~(statement))
#define VO1e(statement,e)                   _VOe(~(statement),e)
#define VO1(statement)                      _VO(~(statement))
//------------------------------------------------------------------------------
#define V1pe(statement,e)                   _Ve(~(N)(statement),e)
#define V1p(statement)                      _V(~(N)(statement))
#define VO1pe(statement,e)                  _VOe(~(N)(statement),e)
#define VO1p(statement)                     _VO(~(N)(statement))
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Utworzenie zmiennej w “menedżerze pamięci”— z ‘uniksowej’ procedury wracającej z wynikiem w “buforze” o podanym rozmiarze.
#define MV_(pointer_variable,v,proc,too_small_errno,max_l) \
  {   N J_autogen_line(l) = ( max_l ) ? ( max_l ) : 1; \
      ( pointer_variable ) = M( J_autogen_line(l) ); \
      if( !( pointer_variable )) \
      {   GV_(NA); V(); \
      } \
      Pc J_autogen_line( p_end ); \
      O{  int errno_; \
          J_ab(v,e)( (proc)(( pointer_variable ), J_autogen_line(l) ), errno_ ) \
          {   if( !( max_l ) \
              && too_small_errno \
              && errno_ == ( too_small_errno ) \
              ) \
              {   if( !E_mem_Q_blk_M_replace( &( pointer_variable ), J_autogen_line(l) += J_autogen_line(l) < E_base_S->E_mem_S_page_size ? J_autogen_line(l) : E_base_S->E_mem_S_page_size )) \
                  {   GV_(NA); V(); \
                  } \
                  continue; \
              } \
              V(); \
          } \
          if( too_small_errno ) \
              break; \
          J_autogen_line( p_end ) = E_text_Z_s_R_0_search(( pointer_variable ), (Pc)( pointer_variable ) + J_autogen_line(l) ); \
          if( J_autogen_line( p_end ) != (Pc)( pointer_variable ) + J_autogen_line(l) ) \
          {   J_autogen_line( p_end )++; \
              break; \
          } \
          if( !E_mem_Q_blk_M_replace( &( pointer_variable ), J_autogen_line(l) += J_autogen_line(l) < E_base_S->E_mem_S_page_size ? J_autogen_line(l) : E_base_S->E_mem_S_page_size )) \
          {   GV_(NA); V(); \
          } \
      } \
      if( too_small_errno ) \
          J_autogen_line( p_end ) = E_text_Z_s0_R_0_end( pointer_variable ); \
      if( (Pc)( pointer_variable ) + J_autogen_line(l) != J_autogen_line( p_end )) \
          if( !E_mem_Q_blk_I_remove( &( pointer_variable ), J_autogen_line( p_end ) - ( pointer_variable ), (Pc)( pointer_variable ) + J_autogen_line(l) - J_autogen_line( p_end ))) \
          {   GV_(NA); \
          } \
  }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#define J_assert(expr)                      assert(expr)
//==============================================================================
    #ifdef E_flow_C_errno_p
#define _errno                              ( *E_flow_S_errno )
    #else
#define _errno                              errno
    #endif
#define _forced_statement                   __asm__ volatile ( "" )
#define _internal                           __attribute__ ((__visibility__( "internal" )))
    #ifndef _unreachable
#define _unreachable                        __builtin_unreachable()
    #endif
#define _unused                             __attribute__ ((__unused__))
//==============================================================================
#define E_mem_Q_file_S_eof                  ( ~1L )
/******************************************************************************/
