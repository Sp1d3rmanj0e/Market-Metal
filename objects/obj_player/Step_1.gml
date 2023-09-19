/// @description Get inputs

key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));

// movement
moveX = (key_right-key_left) * walk_speed;