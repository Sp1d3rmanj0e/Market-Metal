/// @description Hide item if it would bleed into the top view

if (y > MAP_VIEW_Y)
	draw_self();

//draw_line_width(x, y, mouse_x, mouse_y, 5);