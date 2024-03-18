/// @description Insert description here
// You can write your code in this editor



// Add tooltip to show player that their location is a valid spot
if (global.editingTrain and (clicked)) { // If editing the train
	
	var _cartId = get_nearest_cart_id(mouse_x);
	
	if (_cartId != noone) {
		
		draw_set_alpha(0.75);
		draw_set_color(c_ltgray);
		
		if (is_right_of_midpoint(_cartId, mouse_x)) {
			draw_rectangle(_cartId.bbox_right - 15, _cartId.bbox_top,
						   _cartId.bbox_right + 15, _cartId.bbox_bottom,
						   false);
		} else {
			draw_rectangle(_cartId.bbox_left + 15, _cartId.bbox_top,
						   _cartId.bbox_left - 15, _cartId.bbox_bottom,
						   false);
		}
		
		
		
		draw_set_alpha(1);
		draw_set_color(-1);
		
	}
}

//draw_healthbar(bbox_left, bbox_bottom+5, bbox_right, bbox_bottom + 15, 
//	(cart_health/max_cart_health)*100, c_ltgray, c_red, c_green, 0, true, true);