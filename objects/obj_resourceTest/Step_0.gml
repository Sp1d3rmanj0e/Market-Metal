/// @description Insert description here
// You can write your code in this editor

var _currentMapCamX = obj_mapController.map_cam_x;
var _currentMapCamY = obj_mapController.map_cam_y;

var _changeInMapCamX = _currentMapCamX - initial_map_cam_x;
var _changeInMapCamY = _currentMapCamY - initial_map_cam_y;

x = initial_x - _changeInMapCamX;
y = initial_y - _changeInMapCamY;