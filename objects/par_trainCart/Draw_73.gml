/// @description Insert description here
// You can write your code in this editor

var _healthPercent = cart_health/max_cart_health * 100;

draw_set_color(c_white);
draw_rectangle(x - sprite_get_width(sprite_index), bbox_top, x, bbox_bottom, true);

draw_set_color(c_red);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
draw_set_color(-1);

// Add tooltip to show player that their location is a valid spot
if (global.editingTrain and (clicked)) { // If editing the train
	
	var _cartId = get_nearest_cart_id(mouse_x);
	
	if (_cartId != noone) {
		
		draw_set_alpha(0.75);
		draw_set_color(c_ltgray);
		
		if (is_right_of_midpoint(_cartId, mouse_x)) {
			draw_rectangle(_cartId.bbox_right, _cartId.bbox_top,
						   _cartId.bbox_right + 30, _cartId.bbox_bottom,
						   false);
		} else {
			draw_rectangle(_cartId.bbox_left, _cartId.bbox_top,
						   _cartId.bbox_left - 30, _cartId.bbox_bottom,
						   false);
		}
		
		
		
		draw_set_alpha(1);
		draw_set_color(-1);
		
	}
}