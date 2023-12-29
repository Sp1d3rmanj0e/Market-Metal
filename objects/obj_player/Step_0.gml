/// @description Movement & Animations


key_left = keyboard_check(ord("A")) || keyboard_check(vk_left);
key_right = keyboard_check(ord("D")) || keyboard_check(vk_right);

var _move = (key_right - key_left) * walk_speed * -1;

if (_move != 0) image_xscale = sign(_move) * -1;

if (place_meeting(x, y, obj_trainCart)) {
	_move = 0;
}

if (_move != 0) {
	with (obj_trainCart) {
		x += _move;
	}
}
