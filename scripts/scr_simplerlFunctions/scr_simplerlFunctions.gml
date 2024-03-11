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

// Returns an integer between the min and max values, biasing the center values over the edges
function random_probability_curve(_minVal, _maxVal) {
	
	randomize();
	
	var _val1 = random(50);
	var _val2 = random(50);
	
	// Randomized range between 0 and 100 -> 0.0 to 1.0
	var _result = (_val1 + _val2)/100;
	
	// Get the randomized number
	var _returnNumber = (_maxVal-_minVal) * _result + _minVal;
	
	return round(_returnNumber);
}