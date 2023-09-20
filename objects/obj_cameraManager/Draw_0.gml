/// @description Insert description here
// You can write your code in this editor

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
	
	draw_text(mouse_x, mouse_y, "===================");
	
	// Draw outline of camera to show it is clickable
	draw_rectangle_width(
	_miniCamX, _miniCamY, 
	_miniCamX + _miniCamWidth, 
	_miniCamY + _miniCamHeight, 
	50, c_white
	);
}
else
{
	draw_text(mouse_x, mouse_y-50, "not in");
}