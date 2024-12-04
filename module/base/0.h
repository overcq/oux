/*******************************************************************************
*   ___   publicplace
*  ¦OUX¦  C+
*  ¦/C+¦  component
*   ---   base
*         global defines
* ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒7‒6 *
*******************************************************************************/
extern I _X_var( flow, call_req );
extern I _X_var( io, stream_write );
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
extern void E_flow_Q_process_call_I_func(P);
//==============================================================================
#define E_flow_Q_process_call_S_ftok_id 1
//------------------------------------------------------------------------------
    #ifndef C_middle_code
#define _sigaction_M(signum,act)        { V0_( sigaction( (signum), (act), 0 )); }
#define _sigaction_W(signum,act)        { V0_( sigaction( (signum), (act), 0 )); }
    #else
#define _sigaction_S_name(sig)          J_autogen( J_a_b( E_flow_Z_saved_initial_S_sigaction, sig ))
#define _sigaction_M(signum,act)        { V0_( sigaction( (signum), (act), &E_base_S->_sigaction_S_name(signum) )); }
#define _sigaction_W(signum,act)        { V0_( sigaction( (signum), &E_base_S->_sigaction_S_name(signum), 0 )); }
    #endif
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #ifdef C_pthreads
#define _sigprocmask(how,set,oldset)    { Vr_( pthread_sigmask( (how), (set), (oldset) )); }
    #else
#define _sigprocmask(how,set,oldset)    { V0_( sigprocmask( (how), (set), (oldset) )); }
    #endif
    #ifdef C_pthreads
#define _Z_tasks_table_S_edit_begin     Vr_( pthread_mutex_lock( &E_base_S->E_flow_Z_task_table_S_mutex )); _sigprocmask( SIG_BLOCK, &E_base_S->E_flow_Z_sigset_S_process_call_reply, &E_base_S->E_flow_Z_task_table_S_sigset ); E_flow_Q_task_I_touch_stack(); U_L( E_base_S->E_flow_S_mode, Z_task_table_S_can_read )
#define _Z_tasks_table_S_edit_end       U_F( E_base_S->E_flow_S_mode, Z_task_table_S_can_read ); _sigprocmask( SIG_SETMASK, &E_base_S->E_flow_Z_task_table_S_sigset, 0 ); Vr_( pthread_mutex_unlock( &E_base_S->E_flow_Z_task_table_S_mutex ))
    #else
#define _Z_tasks_table_S_edit_begin     _sigprocmask( SIG_BLOCK, &E_base_S->E_flow_Z_sigset_S_process_call_reply, &E_base_S->E_flow_Z_task_table_S_sigset ); E_flow_Q_task_I_touch_stack(); U_L( E_base_S->E_flow_S_mode, Z_task_table_S_can_read )
#define _Z_tasks_table_S_edit_end       U_F( E_base_S->E_flow_S_mode, Z_task_table_S_can_read ); _sigprocmask( SIG_SETMASK, &E_base_S->E_flow_Z_task_table_S_sigset, 0 )
    #endif
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #ifndef E_flow_drv_C_clock_monotonic
typedef struct timeval Z_clock_time;
#define Z_clock_time_minor_field        tv_usec
#define Z_clock_time_minor_field_S_max  999999
#define _gettime(tp)                    { V0_( gettimeofday( (tp), 0 )); }
#warning uses "gettimeofday"; "settimeofday" or clock adjustment may interfere
    #else
typedef struct timespec Z_clock_time;
#define Z_clock_time_minor_field        tv_nsec
#define Z_clock_time_minor_field_S_max  999999999
        #if defined( __gnu_linux__ ) || defined( __FreeBSD__ )
#define _gettime(tp)                    { V0_( clock_gettime( CLOCK_BOOTTIME, (tp) )); }
        #elif defined( __OpenBSD__ )
#define _gettime(tp)                    { V0_( clock_gettime( CLOCK_MONOTONIC, (tp) )); }
        #else
#error not implemented
        #endif
    #endif
//------------------------------------------------------------------------------
    #ifndef E_flow_drv_C_timer_monotonic
        #ifndef E_flow_drv_C_clock_monotonic
#define _setttimer(t) \
  {   struct itimerval itv = \
      { { 0, 0 } \
      , *(t) \
      }; \
      V0_( setitimer( ITIMER_REAL, &itv, 0 )); \
  }
        #else
#define _setttimer(t) \
  {   struct itimerval itv = \
      { { 0, 0 } \
      , ( struct timeval ) \
        { (t)->tv_sec \
        , (t)->tv_nsec / 1000 \
        } \
      }; \
      V0_( setitimer( ITIMER_REAL, &itv, 0 )); \
  }
        #endif
    #else
#define _setttimer(t) \
  {   struct itimerspec its = \
      { { 0, 0 } \
      , *(t) \
      }; \
      V0_( timer_settime( E_base_S->E_flow_S_timer, 0, &its, 0 )); \
  }
    #endif
//------------------------------------------------------------------------------
#define _timerclear(tp) \
  ((void)( \
    *(tp) = ( Z_clock_time ) \
    { (tp)->tv_sec = 0 \
    , (tp)->Z_clock_time_minor_field = 0 \
    } \
  ))
#define _timerover(tp) \
  ((void)( \
    *(tp) = ( Z_clock_time ) \
    { (tp)->tv_sec = LONG_MAX \
    , (tp)->Z_clock_time_minor_field = Z_clock_time_minor_field_S_max \
    } \
  ))
#define _timerisset(tp)                 ( (tp)->tv_sec || (tp)->Z_clock_time_minor_field )
#define _timerisover(tp)                ( (tp)->tv_sec == LONG_MAX && (tp)->Z_clock_time_minor_field == Z_clock_time_minor_field_S_max )
#define _timercmp(a,CMP,b) \
  ( !strcmp( J_s(CMP), "<" ) || !strcmp( J_s(CMP), "<=" ) ? (a)->tv_sec < (b)->tv_sec || ( (a)->tv_sec == (b)->tv_sec && (a)->Z_clock_time_minor_field CMP (b)->Z_clock_time_minor_field ) \
  : !strcmp( J_s(CMP), "==" ) ? (a)->tv_sec CMP (b)->tv_sec && (a)->Z_clock_time_minor_field CMP (b)->Z_clock_time_minor_field \
  : !strcmp( J_s(CMP), "!=" ) ? (a)->tv_sec CMP (b)->tv_sec || (a)->Z_clock_time_minor_field CMP (b)->Z_clock_time_minor_field \
  : !strcmp( J_s(CMP), ">" ) || !strcmp( J_s(CMP), ">=" ) ? (a)->tv_sec > (b)->tv_sec || ( (a)->tv_sec == (b)->tv_sec && (a)->Z_clock_time_minor_field CMP (b)->Z_clock_time_minor_field ) \
  : ( _unreachable, no ) \
  )
// Czy przepełnienie z dodawania dwóch “Z_clock_time_minor_field” zmieści się w rzeczywistym typie danych tej zmiennej w “struct timeval” lub “struct timespec”.
    #if LONG_MAX >= 2 * Z_clock_time_minor_field_S_max
#define _timeradd(a,b,res) \
  {   *(res) = ( Z_clock_time ) \
      { (a)->tv_sec + (b)->tv_sec \
      , (a)->Z_clock_time_minor_field + (b)->Z_clock_time_minor_field \
      }; \
      if( (res)->Z_clock_time_minor_field > Z_clock_time_minor_field_S_max ) \
      {   (res)->tv_sec++; \
          (res)->Z_clock_time_minor_field -= Z_clock_time_minor_field_S_max; \
      } \
  }
#define _timersub(a,b,res) \
  {   *(res) = ( Z_clock_time ) \
      { (a)->tv_sec - (b)->tv_sec \
      , (a)->Z_clock_time_minor_field - (b)->Z_clock_time_minor_field \
      }; \
      if( (res)->Z_clock_time_minor_field < 0 ) \
      {   (res)->tv_sec--; \
          (res)->Z_clock_time_minor_field = Z_clock_time_minor_field_S_max + (res)->Z_clock_time_minor_field; \
      } \
  }
    #else
#warning "timeradd" and "timersub" default implementations are not optimal
#define _timeradd(a,b,res) \
  {   *(res) = ( Z_clock_time ) \
      { (a)->tv_sec + (b)->tv_sec \
        + ( Z_clock_time_minor_field_S_max - (a)->Z_clock_time_minor_field < (b)->Z_clock_time_minor_field ? 1 : 0 ) \
      , ( Z_clock_time_minor_field_S_max - (a)->Z_clock_time_minor_field < (b)->Z_clock_time_minor_field \
        ? Z_clock_time_minor_field_S_max - (( Z_clock_time_minor_field_S_max - (a)->Z_clock_time_minor_field ) + ( Z_clock_time_minor_field_S_max - (b)->Z_clock_time_minor_field )) \
        : (a)->Z_clock_time_minor_field + (b)->Z_clock_time_minor_field \
        ) \
      } \
  }
#define _timersub(a,b,res) \
  {   *(res) = ( Z_clock_time ) \
      { (a)->tv_sec - (b)->tv_sec \
        - ( (a)->Z_clock_time_minor_field < (b)->Z_clock_time_minor_field ? 1 : 0 ) \
      , ( (a)->Z_clock_time_minor_field < (b)->Z_clock_time_minor_field \
        ? Z_clock_time_minor_field_S_max - ( (b)->Z_clock_time_minor_field - (a)->Z_clock_time_minor_field ) \
        : (a)->Z_clock_time_minor_field - (b)->Z_clock_time_minor_field \
        ) \
      } \
  }
    #endif
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #ifdef C_to_libs_C_replace_c_alloc
typedef P ( *E_mem_Q_blk_I_libc_realloc_Z )( P, size_t );
typedef P ( *E_mem_Q_blk_I_libc_reallocarray_Z )( P, size_t, size_t );
typedef void ( *E_mem_Q_blk_I_libc_free_Z )(P);
    #endif
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
struct E_flow_Z_args
{ N argc;
  Pc *argv;
};
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #if defined( E_io_C_aio )
#define E_io_Q_stream_out_S_delay 1
    #elif defined( E_io_C_sig_has_fd )
#define E_io_Q_stream_out_S_delay 1
    #endif
//------------------------------------------------------------------------------
    #if defined( __OpenBSD__ )
struct aiocb
{ int aio_fildes;
  P aio_buf;
  N aio_nbytes;
};
    #elif !defined( __gnu_linux__ ) && !defined( __FreeBSD__ )
#error not implemented
    #endif
/******************************************************************************/
