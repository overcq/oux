/*******************************************************************************
*   ___   publicplace
*  ¦OUX¦  C+
*  ¦/C+¦  compile
*   ---   C+
*         simple common procedures
* ©overcq                on ‟Gentoo Linux 17.1” “x86_64”             2020‒5‒27 T
*******************************************************************************/
#define _inline     static __attribute__((__unused__))
//==============================================================================
_inline
B
E_simple_T_add_overflow(
  N a
, N b
){  return a + b < a;
}
_inline
N
E_simple_Z_n_I_align_down_to_u_R_count( N n
, N u
){  return n / u;
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#define E_simple_Z_p_T_aligned_to_v2(p,v2)      E_simple_Z_n_T_aligned_to_v2( (N)p, v2 )
//------------------------------------------------------------------------------
#define E_simple_Z_p_I_align_down_to_i2(p,i)    (P)E_simple_Z_n_I_align_down_to_i2( (N)p, i )
#define E_simple_Z_p_I_align_up_to_i2(p,i)      (P)E_simple_Z_n_I_align_up_to_i2( (N)p, i )
#define E_simple_Z_p_I_align_down_to_v2(p,v2)   (P)E_simple_Z_n_I_align_down_to_v2( (N)p, v2 )
#define E_simple_Z_p_I_align_up_to_v2(p,v2)     (P)E_simple_Z_n_I_align_up_to_v2( (N)p, v2 )
#define E_simple_Z_p_I_align_down(p)            (P)E_simple_Z_n_I_align_down( (N)p )
#define E_simple_Z_p_I_align_up(p)              (P)E_simple_Z_n_I_align_up( (N)p )
//==============================================================================
#undef _inline
/******************************************************************************/
