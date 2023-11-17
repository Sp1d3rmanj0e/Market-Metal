/// @description Insert description here
// You can write your code in this editor

if (mouse_check_button_pressed(mb_left)) {
	x1 = mouse_x;
	y1 = mouse_y;
}

if (!mouse_check_button(mb_left)) {
	x1 = -1;
}

x2 = mouse_x;
y2 = mouse_y;