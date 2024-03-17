
/// Variables given after creation:
// cart_enum - tells the cart which type it is supposed to be
// side_cart_sprites - an array in the format [interior sprite, exterior sprite] for this specific cart
// cart_index - an integer telling the cart which place along the ds_list it is

#region upgradable stats

// Health
base_cart_health = cart_health;
max_cart_health = cart_health;

#endregion upgradable stats

bogey_id = noone; // Stores the ids of the train bogey

old_cart_position = -1; // Stores the position of the cart prior to it being picked up;

clicked = false; // Tells the cart if the mouse is dragging it or not

// When dragging the cart, this tells the cart the exact position to be relative to the mouse
mouse_x_off = 0;
mouse_y_off = 0;

// Unpack the side cart sprites
interior_sprite = side_cart_sprites[0];
exterior_sprite = side_cart_sprites[1];

sprite_index = interior_sprite;

cover_id = instance_create_layer(x, y, "Cart_Covers", obj_trainCartCover,
{
	sprite_index : exterior_sprite,
	parent : id
});

if (cart_enum != CARTS.ENGINE) {
	bogey_id = instance_create_layer(x, y, "Bogeys", obj_trainCartBogey, {
		sprite_index : get_bogey_size(cart_enum)
	});
}

instance_create_layer(bbox_right - 20, bbox_top + sprite_height/2, "Cart_Interactables", obj_upgradeTerminal,
					  {
						  parent_id : id
					  })

function update_bogey_location() {
	with(bogey_id) {
		x = other.x;
		y = other.y;
	}
}

// Draws a vertical line and returns the cart that is colliding with it
// If no carts are colliding, it will return noone
function get_nearest_cart_id(_x = mouse_x) {
	return collision_line(_x, 0, _x, MAP_VIEW_Y, par_trainCart, false, true);
}

// Returns the middle x-point of an instance
function get_id_midpoint(_id) {
	return _id.bbox_left + _id.sprite_width/2;
}

// Returns true if _x is greater than the instance's midpoint
function is_right_of_midpoint(_id, _x = mouse_x) {
	var _midpoint = get_id_midpoint(_id);
	return (_x > _midpoint);
}

// Returns the ds_list index of the requested spot to place a train cart
function find_valid_cart_insert(_x = mouse_x) {
	
	// Get id of the nearest cart on a horizontal axis
	var _nearestCartId = get_nearest_cart_id(_x);
	
	// Return that the check was invalid if no target was touched
	if  (_nearestCartId == noone) {
		return noone;
	}
	
	var _cartIndex = _nearestCartId.cart_index;
	
	// Left
	if (is_right_of_midpoint(_nearestCartId, mouse_x)) {
		return _cartIndex;
	} else { // Right
		return _cartIndex+1;
	}
	
}

function update_upgrades(_upgradePacket) {
	
	log(string(_upgradePacket));
}