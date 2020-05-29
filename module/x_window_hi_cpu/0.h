/*******************************************************************************
*   ___   publicplace
*  ¦OUX¦  C+
*  ¦/C+¦  component
*   ---   ‟Xorg” —high ‘cpu’
*         global defines
* ©overcq                on ‟Gentoo Linux 13.0” “x86_64”              2015‒9‒4 *
*******************************************************************************/
    #ifdef C_id_small
#define E_x_Q_obj_C_id_bits         16
    #else
#define E_x_Q_obj_C_id_bits         32
    #endif
#define E_x_Q_window_C_hidden_x     -1
#define E_x_Q_window_C_hidden_y     -1
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
enum E_x_Q_display_Z_atom
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
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#define E_x_Q_window_I_draw_P_color_(color)             E_x_Q_window_I_draw_P_color( display, screen, color )
#define E_x_Q_window_I_draw_Z_points_(points)           E_x_Q_window_I_draw_Z_points( display, screen, window, sizeof(points) / sizeof( xcb_point_t ), points )
#define E_x_Q_window_I_draw_Z_segments_(points)         E_x_Q_window_I_draw_Z_segments( display, screen, window, sizeof(segments) / sizeof( xcb_segment_t ), segments )
#define E_x_Q_window_I_draw_Z_lines_(points)            E_x_Q_window_I_draw_Z_lines( display, screen, window, sizeof(points) / sizeof( xcb_point_t ), points )
#define E_x_Q_window_I_draw_Z_rectangles_(points)       E_x_Q_window_I_draw_Z_rectangles( display, screen, window, sizeof(rectangles) / sizeof( xcb_rectangle_t ), rectangles )
#define E_x_Q_window_I_draw_Z_arcs_(arcs)               E_x_Q_window_I_draw_Z_arcs( display, screen, window, sizeof(arcs) / sizeof( xcb_arc_t ), rectangles )
#define E_x_Q_window_I_fill_Z_points_(points)           E_x_Q_window_I_fill_Z_points( display, screen, window, sizeof(points) / sizeof( xcb_point_t ), points )
#define E_x_Q_window_I_fill_Z_rectangles_(rectangles)   E_x_Q_window_I_fill_Z_rectangles( display, screen, window, sizeof(rectangles) / sizeof( xcb_rectangle_t ), rectangles )
#define E_x_Q_window_I_fill_Z_arcs_(arcs)               E_x_Q_window_I_fill_Z_arcs( display, screen, window, sizeof(arcs) / sizeof( xcb_arc_t ), arcs )
//------------------------------------------------------------------------------
#define E_x_Q_object_I_draw_P_color_(color)             E_x_Q_object_I_draw_P_color( display, screen, object, color )
#define E_x_Q_object_I_draw_Z_points_(points)           E_x_Q_object_I_draw_Z_points( display, screen, window, object, sizeof(points) / sizeof( xcb_point_t ), points )
#define E_x_Q_object_I_draw_Z_segments_(segments)       E_x_Q_object_I_draw_Z_segments( display, screen, window, object, sizeof(segments) / sizeof( xcb_segment_t ), segments )
#define E_x_Q_object_I_draw_Z_lines_(points)            E_x_Q_object_I_draw_Z_lines( display, screen, window, object, sizeof(points) / sizeof( xcb_point_t ), points )
#define E_x_Q_object_I_draw_Z_rectangles_(rectangles)   E_x_Q_object_I_draw_Z_rectangles( display, screen, window, object, sizeof(rectangles) / sizeof( xcb_rectangle_t ), rectangles )
#define E_x_Q_object_I_draw_Z_arcs_(arcs)               E_x_Q_object_I_draw_Z_arcs( display, screen, window, object, sizeof(arcs) / sizeof( xcb_arc_t ), arcs )
#define E_x_Q_object_I_fill_Z_points_(points)           E_x_Q_object_I_fill_Z_points( display, screen, window, object, sizeof(points) / sizeof( xcb_point_t ), points )
#define E_x_Q_object_I_fill_Z_rectangles_(rectangles)   E_x_Q_object_I_fill_Z_rectangles( display, screen, window, object, sizeof(rectangles) / sizeof( xcb_rectangle_t ), rectangles )
#define E_x_Q_object_I_fill_Z_arcs_(arcs)               E_x_Q_object_I_fill_Z_arcs( display, screen, window, object, sizeof(arc) / sizeof( xcb_arc_t ), arcs )
//------------------------------------------------------------------------------
#define E_x_Q_window_I_draw_aa_Z_pixel_( x, y, color, brightness, get_pixel )   E_x_Q_window_I_draw_aa_Z_pixel( display, screen, window, x, y, color, brightness, get_pixel )
#define E_x_Q_window_I_draw_aa_Z_lines_( n, points, thickness, color )  E_x_Q_window_I_draw_aa_Z_lines( display, screen, window, n, points, thickness, color )
//------------------------------------------------------------------------------
#define E_x_Q_window_I_draw_Z_font_( x, y, color, id, u )       E_x_Q_window_I_draw_Z_font( display, screen, window, x, y, color, id, u )
#define E_x_Q_window_I_draw_Z_font_Z_s_( x, y, color, id, s )   E_x_Q_window_I_draw_Z_font_Z_s( display, screen, window, x, y, color, id, s )
#define E_x_Q_object_I_draw_Z_font_( x, y, color, id, u )       E_x_Q_object_I_draw_Z_font( display, screen, window, object, x, y, color, id, u )
#define E_x_Q_object_I_draw_Z_font_Z_s_( x, y, color, id, s )   E_x_Q_object_I_draw_Z_font_Z_s( display, screen, window, object, x, y, color, id, s )
/******************************************************************************/
