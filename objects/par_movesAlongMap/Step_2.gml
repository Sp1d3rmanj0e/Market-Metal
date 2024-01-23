/// @description Change position based on map movement

var _currentMapCamX = obj_mapController.map_cam_x;
var _currentMapCamY = obj_mapController.map_cam_y;

var _changeInMapCamX = _currentMapCamX - initial_map_cam_x;
var _changeInMapCamY = _currentMapCamY - initial_map_cam_y;

x = initial_x - _changeInMapCamX + x_off;
y = initial_y - _changeInMapCamY + y_off;