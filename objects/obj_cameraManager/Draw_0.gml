/// @description Insert description here
// You can write your code in this editor

// Get camera dimensions
var _miniCamX	   = camera_get_view_x	   (view_get_camera(VIEW.MINI));
var _miniCamY	   = camera_get_view_y	   (view_get_camera(VIEW.MINI));
var _miniCamWidth  = camera_get_view_width (view_get_camera(VIEW.MINI));
var _miniCamHeight = camera_get_view_height(view_get_camera(VIEW.MINI));

// Check if mouse is within minicam box
if (point_in_rectangle(
mouse_x, mouse_y, 
_miniCamX, _miniCamY, 
_miniCamX + _miniCamWidth, 
_miniCamY + _miniCamHeight)
) {
	
	draw_set_color(c_white);
	draw_set_alpha(0.25);
	
	// Draw outline of camera to show it is clickable
	draw_rectangle(
	_miniCamX, _miniCamY, 
	_miniCamX + _miniCamWidth, 
	_miniCamY + _miniCamHeight, 
	false);
	
	resetDraw();
	
	// If clicked, flip cams
	if (mouse_check_button_pressed(mb_left)) {
		flipCams();
	}
}