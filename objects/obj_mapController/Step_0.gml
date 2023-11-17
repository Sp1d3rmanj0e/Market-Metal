/// @description Camera Movement


key_left	= keyboard_check(vk_left)	|| keyboard_check(ord("A"));
key_right	= keyboard_check(vk_right)	|| keyboard_check(ord("D"));
key_up		= keyboard_check(vk_up)		|| keyboard_check(ord("W"));
key_down	= keyboard_check(vk_down)	|| keyboard_check(ord("S"));

var _move_x = key_right-key_left;
var _move_y = key_down-key_up;

map_cam_move_speed = 15 + obj_cameraManager.map_zoom*5

map_cam_x += map_cam_move_speed * _move_x;
map_cam_y += map_cam_move_speed * _move_y;