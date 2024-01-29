/// @description Insert description here
// You can write your code in this editor





if (y > MAP_VIEW_Y)
	draw_self();

draw_set_color(c_aqua);
draw_line_width(x, y, mouse_x, mouse_y, 5);
draw_set_color(-1);

draw_text(x, y+40, "is_outside: " + string(is_outdoors));
draw_text(x, y+60, "profession: " + string(profession));