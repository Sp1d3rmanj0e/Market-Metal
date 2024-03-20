/// @description Insert description here
// You can write your code in this editor

walk_speed = 2;
inventory_id = create_inventory(8);
add_item(inventory_id, 0, ITEM.IRON, "Iron", spr_iron_item, 1, "it's just iron");
add_item(inventory_id, 1, ITEM.WOOD, "Wood", spr_wood_item, 1, "it's just wood");
add_item(inventory_id, 2, ITEM.UPG_HEALTH, "Health Upgrade", spr_itemError, 1, "balls");
add_item(inventory_id, 3, ITEM.UPG_CAPACITY, "Capacity Upgrade", spr_itemError, 1, "balls");
focusing_camera = false;

function focus_camera(_cartId) {
	
	// Hides the player
	focusing_camera = true;
	
	camera_set_view_size(get_side_camera(), 320, 180);
	camera_set_view_pos(get_side_camera(), camera_get_view_x(get_side_camera()), 90);
	
	// Get center x of the focused cart
	var _cartLeft = _cartId.bbox_left;
	var _cartRight = _cartId.bbox_right;
	var _cartMid = (_cartLeft + _cartRight)/2;
	
	// Get the middle of the camera
	var _camX = camera_get_view_x(get_side_camera());
	var _camW = camera_get_view_width(get_side_camera());
	var _camMid = _camX + _camW/2;
	
	// Returns how much further the camera mid is than the cart mid
	var _trainMovementDelta = _camMid - _cartMid; 
	
	train_movement = _trainMovementDelta;
	move_train_side(_trainMovementDelta);
}

function unfocus_camera() {
	
	// Unhides the player
	focusing_camera = false;
	
	camera_set_view_size(get_side_camera(), 640, 360);
	camera_set_view_pos(get_side_camera(), camera_get_view_x(get_side_camera()), 0);
	move_train_side(-train_movement);
}