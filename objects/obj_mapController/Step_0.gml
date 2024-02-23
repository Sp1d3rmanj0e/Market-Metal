/// @description Camera Movement

if (global.currentCamera == CAM.MAP) {
	key_left	= keyboard_check(vk_left)	|| keyboard_check(ord("A"));
	key_right	= keyboard_check(vk_right)	|| keyboard_check(ord("D"));
	key_up		= keyboard_check(vk_up)		|| keyboard_check(ord("W"));
	key_down	= keyboard_check(vk_down)	|| keyboard_check(ord("S"));

	var _move_x = key_right-key_left;
	var _move_y = key_down-key_up;

	if ((_move_x != 0) || (_move_y != 0)) {
		
		if (!global.playerDismounted)
			centered_camera = false;
	}

	map_cam_move_speed = 15 + obj_cameraManager.map_zoom*5;

	map_cam_x += map_cam_move_speed * _move_x;
	map_cam_y += map_cam_move_speed * _move_y;
}


// Centering camera
if (centered_camera) {
	
	// Find the center position of the train  TODO: (or player if dismounted)
	var _camWidth = camera_get_view_width(get_map_camera());
	var _camY = camera_get_view_y(get_map_camera());
	var _camHeight = camera_get_view_height(get_map_camera());
	
	var _focusedMapCamX, _focusedMapCamY
	
	if (!global.playerDismounted) {
		_focusedMapCamX = global.train_x - _camWidth/2;
		_focusedMapCamY = global.train_y - _camY - _camHeight/2;
	} else {
		_focusedMapCamX = obj_playerTop.x + map_cam_x - _camWidth/2;
		_focusedMapCamY = obj_playerTop.y + map_cam_y - _camY - _camHeight/2;
	}
	
	// Glide camera over to the correct camera position
	var _camXDiff = _focusedMapCamX - map_cam_x;
	var _camYDiff = _focusedMapCamY - map_cam_y;
	
	map_cam_x += _camXDiff/3;
	map_cam_y += _camYDiff/3;
	
	/*
	map_cam_x = _focusedMapCamX;
	map_cam_y = _focusedMapCamY;
	*/
}