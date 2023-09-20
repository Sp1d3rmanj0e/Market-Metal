// Draw a rectangle with varying border widths and colors
function draw_rectangle_width(_x1, _y1, _x2, _y2, _width, _color) {
	
	// Set color
	draw_set_color(_color);
	
	// Top Left to Top Right
	draw_line_width(_x1, _y1, _x2, _y1, _width);
	
	// Top Right to Bottom Right
	draw_line_width(_x2, _y1, _x2, _y2, _width);
	
	// Bottom Right to Bottom Left
	draw_line_width(_x2, _y2, _x1, _y2, _width);
	
	// Bottom Left to Top Left
	draw_line_width(_x1, _y2, _x1, _y1, _width);
	
	// Reset color
	draw_set_color(c_black);
}

function resetDraw() {
	draw_set_color(c_black);
	draw_set_font(-1);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}