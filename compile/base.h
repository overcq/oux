/*******************************************************************************
*   ___   publicplace
*  ¦OUX¦  C+
*  ¦/C+¦  compile
*   ---   C+
*         simple common procedures
* ©overcq                on ‟Gentoo Linux 17.1” “x86_64”            2020‒11‒28 Z
*******************************************************************************/
#define __inline static __attribute__ ((__always_inline__,__unused__))
//==============================================================================
__inline
Pc
E_text_Z_s0_R_end( Pc s
){  while( *s )
        s++;
    return s;
}
__inline
N
E_text_Z_s0_R_l( Pc s
){  return E_text_Z_s0_R_end(s) - s;
}
__inline
Pc
E_text_Z_s0_R_0_end( Pc s
){  return E_text_Z_s0_R_end(s) + 1;
}
__inline
N
E_text_Z_s0_R_0_l( Pc s
){  return E_text_Z_s0_R_0_end(s) - s;
}
//------------------------------------------------------------------------------
__inline
Pc
E_text_Z_s_P_0( Pc s
){  *s++ = '\0';
    return s;
}
__inline
Pc
E_text_Z_s0_R_c_search_last( Pc s
, C c
){  return E_text_Z_s_R_c_search_last( s, E_text_Z_s0_R_0_end(s), c );
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__inline
int
E_mem_Q_shared_M( N size
){  return E_mem_Q_shared_M_key( IPC_PRIVATE, size );
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__inline
B
E_mem_Q_tab_T( struct E_mem_Q_tab_Z *tab
, I id
){  return (In)id < (In)tab->index_n
    && tab->index[id];
}
__inline
I
E_mem_Q_tab_R_n( struct E_mem_Q_tab_Z *tab
){  return tab->data_n;
}
__inline
P
E_mem_Q_tab_R( struct E_mem_Q_tab_Z *tab
, I id
){  J_assert( E_mem_Q_tab_T( tab, id ));
    return tab->index[id];
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__inline
B
E_flow_Q_task_R_exit( void
){  struct E_flow_Q_task_Z *task = E_mem_Q_tab_R( E_base_S->E_flow_Q_task_S, E_base_S->E_flow_Q_task_S_current );
    return task->run_state == E_flow_Z_run_state_S_stopping_by_task;
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__inline
int
E_mem_Q_file_R_fd( I id
){  struct E_mem_Q_file_Z *file = E_mem_Q_tab_R( E_base_S->E_mem_Q_file_S, id );
    return file->fd;
}
__inline
N
E_mem_Q_file_R_pos( I id
){  struct E_mem_Q_file_Z *file = E_mem_Q_tab_R( E_base_S->E_mem_Q_file_S, id );
    return file->pos;
}
//------------------------------------------------------------------------------
__inline
N
E_mem_Q_file_R_16( I id
, N *v
){  return E_mem_Q_file_R_N( id, v, 2 );
}
__inline
N
E_mem_Q_file_R_32( I id
, N *v
){  return E_mem_Q_file_R_N( id, v, 2 );
}
__inline
N
E_mem_Q_file_R_64( I id
, N *v
){  return E_mem_Q_file_R_N( id, v, 2 );
}
//------------------------------------------------------------------------------
__inline
N
E_mem_Q_file_P_16( I id
, N v
){  return E_mem_Q_file_P_N( id, v, 2 );
}
__inline
N
E_mem_Q_file_P_32( I id
, N v
){  return E_mem_Q_file_P_N( id, v, 4 );
}
__inline
N
E_mem_Q_file_P_64( I id
, N v
){  return E_mem_Q_file_P_N( id, v, 8 );
}
//------------------------------------------------------------------------------
__inline
N
E_mem_Q_file_P_insert_c( I id
, C c
){  return E_mem_Q_file_P_insert_s( id, &(( C[] ){ c })[0], 1 );
}
__inline
N
E_mem_Q_file_P_insert_16( I id
, N v
){  return E_mem_Q_file_P_insert_N( id, v, 2 );
}
__inline
N
E_mem_Q_file_P_insert_32( I id
, N v
){  return E_mem_Q_file_P_insert_N( id, v, 4 );
}
__inline
N
E_mem_Q_file_P_insert_64( I id
, N v
){  return E_mem_Q_file_P_insert_N( id, v, 8 );
}
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__inline
B
E_math_bignum_R_sign( struct E_math_bignum_Z_num *num
){  return (S)num->digits[ num->digits_n - 1 ] < 0;
}
__inline
N
E_math_bignum_I_divide_modulo(
  struct E_math_bignum_Z_num *num_0
, struct E_math_bignum_Z_num *num_1
){  return E_math_bignum_I_divide_modulo_min_prec( num_0, num_1, 0 );
}
/******************************************************************************/
