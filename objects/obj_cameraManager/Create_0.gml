/// @description Insert description here
// You can write your code in this editor

zoomed_in = false;
zoom = 0; // 0-1 controls lerp
zoom_speed = 0.05;

function updateMapLocation() {
var _cam0_width = camera_get_view_width(view_camera[0]);
var _cam0_height = camera_get_view_height(view_camera[0]);
var _cam0_x = camera_get_view_x(view_camera[0]);
var _cam0_y = camera_get_view_y(view_camera[0]);
var _cam1_width = camera_get_view_width(view_camera[1]);
var _cam1_height = camera_get_view_height(view_camera[1]);

// Set the map camera to be in the bottom right corner
view_set_xport(1, _cam0_x + _cam0_width - _cam1_width);
view_set_yport(, _cam0_y + _cam0_height - _cam1_height);
}

updateMapLocation();