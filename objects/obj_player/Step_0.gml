/// @description Movement & Animations

// Get keyboard input
key_left = keyboard_check(ord("A")) || keyboard_check(vk_left);
key_right = keyboard_check(ord("D")) || keyboard_check(vk_right);

// Calculate movement direction
var _move = (key_right - key_left) * walk_speed * -1;

// Flip character based on motion
if (_move != 0) image_xscale = sign(_move) * -1;

// Stop moving if reached a train collision point
// TODO: Assess if this is still relevant
if (place_meeting(x, y, obj_trainCart)) {
	_move = 0;
}

// Tell the train to move (to simulate the player walking)
if (_move != 0) and (global.currentCamera == CAM.SIDE) {
	with (obj_trainController) {
		x += _move;
	}
	with (obj_employeeTop) {
		if (!is_outdoors) {
			x += _move;
		}
	}
}
