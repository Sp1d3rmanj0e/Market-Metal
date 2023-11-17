/// @description Click to flip cams and scrolling
if (map_open) {
	var _workingCamera = view_get_camera(VIEW.MAIN);
	
	// Scroll both cameras equal to their aspect ratio (2560 width X 1440 height)
	// The scroll magnitude is 300 high per scroll and the respective ratio wide
	var _newCamWidth = 2560 + map_zoom * (2560/1440 * 300);
	var _newCamHeight = 1440 + map_zoom * 300
		
	// Update the samera cettings accordingly
	camera_set_view_size(_workingCamera, _newCamWidth, _newCamHeight);
	camera_set_view_pos(_workingCamera, 0, MAP_VIEW_Y + MAP_VIEW_HEIGHT/2 - _newCamHeight/2);
}

#region flipping camera

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
#endregion flipping camera