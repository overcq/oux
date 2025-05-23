/*******************************************************************************
*   ___   publicplace
*  ¦OUX¦  C+
*  ¦/C+¦  component
*   ---   ‟Xorg” —high ‘cpu’
*         global defines
* ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒9‒4 *
*******************************************************************************/
    #ifdef C_id_small
#define E_gui_xcb_Q_obj_C_id_bits         16
    #else
#define E_gui_xcb_Q_obj_C_id_bits         32
    #endif
#define E_gui_xcb_Q_window_C_hidden_x     -10000
#define E_gui_xcb_Q_window_C_hidden_y     -10000
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    #ifdef __NetBSD__
#define XCB_ICCCM_SIZE_HINT_P_MIN_SIZE XCB_SIZE_HINT_P_MIN_SIZE
#define XCB_ICCCM_WM_HINT_INPUT XCB_WM_HINT_INPUT
#define XCB_ICCCM_WM_HINT_STATE XCB_WM_HINT_STATE
#define XCB_ICCCM_WM_STATE_NORMAL XCB_WM_STATE_NORMAL
typedef xcb_wm_hints_t xcb_icccm_wm_hints_t;
    #endif
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#define XCB_ATOM_LAST_PREDEFINED    XCB_ATOM_WM_TRANSIENT_FOR
#define XCB_ATOM_FIRST_DEFINED_     C_STRING
#define XCB_ATOM_FIRST_DEFINED      J_ab( XCB_ATOM_, XCB_ATOM_FIRST_DEFINED_ )
#define E_x_Z_atom_J_atoms_ \
, _( UTF8_STRING ) \
, _( WM_DELETE_WINDOW ) \
, _( WM_PROTOCOLS ) \
, _( _NET_WM_BYPASS_COMPOSITOR ) \
, _( _NET_WM_ICON ) \
, _( _NET_WM_ICON_NAME ) \
, _( _NET_WM_NAME ) \
, _( _NET_WM_PID ) \
, _( _NET_WM_PING ) \
, _( _NET_WM_USER_TIME ) \
, _( _NET_WM_WINDOW_TYPE ) \
, _( _NET_WM_WINDOW_TYPE_DND ) \
, _( _NET_WM_WINDOW_TYPE_NORMAL ) \
// Tutaj kolejne używane ‘atomy’ ‘x’.
//==============================================================================
#define _(atom) J_ab( XCB_ATOM_, atom )
enum E_gui_xcb_Q_display_Z_atom
{ _( XCB_ATOM_FIRST_DEFINED_ ) = XCB_ATOM_LAST_PREDEFINED + 1
  E_x_Z_atom_J_atoms_
, _( AFTER_LAST )
};
#undef _
//==============================================================================
#define E_x_Z_atom_R(display,atom_) \
( (N)J_ab( XCB_ATOM_, atom_ ) > (N)XCB_ATOM_LAST_PREDEFINED \
  ? (display)->atom[ J_ab( XCB_ATOM_, atom_ ) - XCB_ATOM_FIRST_DEFINED ] \
  : J_ab( XCB_ATOM_, atom_ ) \
)
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#define E_x_Z_property_P_(display,window,property,type,cell,n,value_p) \
    xcb_change_property( (display)->x_display \
    , XCB_PROP_MODE_REPLACE \
    , (window)->x_window \
    , E_x_Z_atom_R( (display), property ) \
    , E_x_Z_atom_R( (display), type ) \
    , (cell) \
    , (n) \
    , ( N8 * )(value_p) \
    )
#define E_x_Z_property_P(display,window,property,type,value) \
    E_x_Z_property_P_( (display) \
    , (window) \
    , property \
    , type \
    , 32 \
    , sizeof (value) / 4 \
    , &(value) \
    )
#define E_x_Z_property_P_v(display,window,property,type,value) \
{   N32 J_autogen(v) = (value); \
    E_x_Z_property_P( (display) \
    , (window) \
    , property \
    , type \
    , J_autogen(v) \
    ); \
}
#define E_x_Z_property_P_atom(display,window,property,atom_) \
    E_x_Z_property_P_v( (display), (window) \
    , property \
    , ATOM \
    , E_x_Z_atom_R( (display), atom_ ) \
    )
#define E_x_Z_property_P_text(display,window,property,type,text,l) \
    E_x_Z_property_P_( (display) \
    , (window) \
    , property \
    , type \
    , 8 \
    , ~(l) ? (l) : E_text_Z_s0_R_l(text) \
    , (text) \
    )
/******************************************************************************/
