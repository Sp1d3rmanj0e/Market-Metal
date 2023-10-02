function resetDraw() {
	draw_set_color(c_black);
	draw_set_font(-1);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

function log(_message) {
	show_debug_message(string(_message));
}

function rgb(_r, _g, _b) {
	return make_color_rgb(_r, _g, _b);
}