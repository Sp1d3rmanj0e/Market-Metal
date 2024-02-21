/// @description Insert description here
// You can write your code in this editor

if (point_in_rectangle(
	mouse_x, mouse_y, 
	bbox_left, bbox_bottom-sprite_width, 
	bbox_left + sprite_width, bbox_bottom)) {
	
	if (mouse_check_button_pressed(mb_left)) {
		show_inventory = true;
	}
}