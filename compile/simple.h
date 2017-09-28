/*******************************************************************************
*   ___   publicplace
*  ¦OUX¦  ‟Coux”
*  ¦Inc¦  compile
*   ---   ‟Coux”
*         simple common procedures
* ©overcq                on ‟Gentoo Linux 13.0” “x86_64”             2015‒4‒28 *
*******************************************************************************/
//NDFN rozwiązanie “inline” tylko dla tego pliku.
#define _inline                     static __attribute__ ((__unused__))
//==============================================================================
_inline
N
E_asm_I_bsr( N n
){  N i;
        #if defined( __i386__ ) || defined( __x86_64__ )
    N v;
    __asm__ volatile (
    "\n" "orl   $~0,%0"
    "\n" "bsr   %2,%1"
    "\n" "cmove %0,%1"
    : "=g" (v), "=r" (i)
    : "g" (n)
    : "cc"
    );
        #else
    if(n)
        i = sizeof(N) * 8 - 1 - __builtin_clzl(n);
    else
        i = ~0;
        #endif
    return i;
}
//==============================================================================
_inline
B
E_simple_T_add_overflow(
  N a
, N b
){  return a + b < a;
}
_inline
B
E_simple_T_multiply_overflow(
  N a
, N b
){  return a && b
    && ( E_asm_I_bsr(a) != ~0 ? E_asm_I_bsr(a) : 0 )
      + ( E_asm_I_bsr(b) != ~0 ? E_asm_I_bsr(b) : 0 )
      >= sizeof(N) * 8;
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
_inline
B
E_simple_Z_n_T_power_2( N n
){  return n ? __builtin_clzl(n) + 1 + __builtin_ctzl(n) == sizeof(N) * 8 : 0;
}
_inline
B
E_simple_Z_n_T_aligned_to_v_2( N n
, N v_2
){  return !( n & ( v_2 - 1 ));
}
//------------------------------------------------------------------------------
_inline
N
E_simple_Z_n_I_mod_i_2( N n
, N i
){  return n & ( _v( n, ~0 ) >> ( sizeof(n) * 8 - i ));
}
_inline
N
E_simple_Z_n_I_align_down_to_i_2( N n
, N i
){  return n & ( _v( n, ~0 ) << i );
}
_inline
N
E_simple_Z_n_I_align_up_to_i_2( N n
, N i
){  N a = _v( n, ~0 ) << i;
    return ( n + ~a ) & a;
}
_inline
N
E_simple_Z_n_I_align_down_to_v_2( N n
, N v_2
){  return n & ~( v_2 - 1 );
}
_inline
N
E_simple_Z_n_I_align_up_to_v_2( N n
, N v_2
){  N a = v_2 - 1;
    return ( n + a ) & ~a;
}
_inline
N
E_simple_Z_n_I_align_down_to_v( N n
, N v
){  return n - ( n % v );
}
_inline
N
E_simple_Z_n_I_align_up_to_v( N n
, N v
){  N a = n % v;
    return a ? n + v - a : n;
}
_inline
N
E_simple_Z_n_I_align_down_to_u_R_count( N n
, N u
){  return n / u;
}
_inline
N
E_simple_Z_n_I_align_up_to_u_R_count( N n
, N u
){  N a = n / u;
    if( n % u )
        a += u;
    return a;
}
_inline
N
E_simple_Z_n_I_align_down( N n
){  if( !n )
        return n;
    return _v( n, 1 ) << ( sizeof(N) * 8 - 1 - __builtin_clzl(n) );
}
_inline
N
E_simple_Z_n_I_align_up( N n
){  if( !n )
        return n;
    N a = _v( n, ~0 ) << ( sizeof(N) * 8 - 1 - __builtin_clzl(n) );
    return ( n + ~a ) & a;
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
_inline
B
E_simple_Z_p_T_inside( P p_1
, P p_2
, N l_2
){  return (Pc)p_1 >= (Pc)p_2
    && (Pc)p_1 < (Pc)p_2 + l_2;
}
_inline
B
E_simple_Z_p_T_cross( P p_1
, N l_1
, P p_2
, N l_2
){  return E_simple_Z_p_T_inside( p_2, p_1, l_1 )
    || E_simple_Z_p_T_inside( p_1, p_2, l_2 );
}
_inline
B
E_simple_Z_p_T_aligned_to_v_2( P p
, N v_2
){  return E_simple_Z_n_T_aligned_to_v_2( (N)p, v_2 );
}
//------------------------------------------------------------------------------
_inline
P
E_simple_Z_p_I_align_down_to_i_2( P p
, N i
){  return (P)E_simple_Z_n_I_align_down_to_i_2( (N)p, i );
}
_inline
P
E_simple_Z_p_I_align_up_to_i_2( P p
, N i
){  return (P)E_simple_Z_n_I_align_up_to_i_2( (N)p, i );
}
_inline
P
E_simple_Z_p_I_align_down_to_v_2( P p
, N v_2
){  return (P)E_simple_Z_n_I_align_down_to_v_2( (N)p, v_2 );
}
_inline
P
E_simple_Z_p_I_align_up_to_v_2( P p
, N v_2
){  return (P)E_simple_Z_n_I_align_up_to_v_2( (N)p, v_2 );
}
_inline
P
E_simple_Z_p_I_align_down( P p
){  return (P)E_simple_Z_n_I_align_down( (N)p );
}
_inline
P
E_simple_Z_p_I_align_up( P p
){  return (P)E_simple_Z_n_I_align_up( (N)p );
}
//==============================================================================
#undef _inline
/******************************************************************************/
