/// @description Moving the cart


// Detect if mouse is dragging it
if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
	
	if (mouse_check_button_pressed(mb_left) and !clicked and !global.activelyMovingCart) {
		clicked = true;
		global.activelyMovingCart = true;
		
		// Save the mouse offset from the cart's origin for consistency
		mouse_x_off = mouse_x - x;
		mouse_y_off = mouse_y - y;
		
		// Remove the cart from the train list (temporarily)
		with(obj_trainController) {remove_cart(other.id);}
	}
}

// Check if mouse released it
if (clicked and !mouse_check_button(mb_left)) {
	clicked = false;
	global.activelyMovingCart = false;
}
	
//Follow mouse while it's being dragged
if (clicked) {
	x = mouse_x - mouse_x_off;
	y = mouse_y - mouse_y_off;
	update_bogey_location();
}