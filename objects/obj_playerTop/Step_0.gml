/// @description Insert description here
// You can write your code in this editor


move_left  = keyboard_check(ord("A"));
move_right = keyboard_check(ord("D"));
move_up    = keyboard_check(ord("W"));
move_down  = keyboard_check(ord("S"));

if (obj_mapController.centered_camera) {
	
	// TODO: Remove diagonal moving speed
	var _moveX = (move_right - move_left) * walk_speed;
	var _moveY = (move_down - move_up) * walk_speed;
	
	image_angle = point_direction(0, 0, _moveX, _moveY)-90;
	
	x_off += _moveX;
	y_off += _moveY;
}
