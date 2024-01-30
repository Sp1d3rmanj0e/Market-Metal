/// @description Insert description here
// You can write your code in this editor

if (!detonated) {
	if (position_meeting(mouse_x, mouse_y, id)) {
		image_index = 1; // (Primed)
	} else {
		image_index = 0; // (Normal)
	}
}