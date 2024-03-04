/// @description Destroy self if mouse clicks off of it

if (mouse_check_button_pressed(mb_left)) {
	if (!point_in_rectangle(mouse_x, mouse_y, x, y, x + width, y + height)) {
		instance_destroy();
	}
}