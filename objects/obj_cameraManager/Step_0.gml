/// @description Insert description here
// You can write your code in this editor

var _miniCamX	   = view_get_xport(VIEW.MINI);
var _miniCamY	   = view_get_yport(VIEW.MINI);
var _miniCamWidth  = view_get_wport(VIEW.MINI);
var _miniCamHeight = view_get_hport(VIEW.MINI);

// Check if mouse is within minicam box
if (point_in_rectangle(
mouse_x, mouse_y, 
_miniCamX, _miniCamY, 
_miniCamX + _miniCamWidth, 
_miniCamY + _miniCamHeight)
) {
	// Draw outline of camera to show it is clickable
	draw_rectangle_width(
	_miniCamX, _miniCamY, 
	_miniCamX + _miniCamWidth, 
	_miniCamY + _miniCamHeight, 
	5, c_white
	);
	
	// Check if clicked NO WORK
	if (mouse_check_button_pressed(mb_left))
	{
		flipCams();
	}
}