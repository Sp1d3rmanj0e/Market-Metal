/// @description Insert description here
// You can write your code in this editor


// Initialize an array to store the IDs of carts it creates
cart_ids = ds_list_create();

// The X and Y symbolize the start of the train
// We do this so that the only thing we need to do in order to move the train is to move this object
x = 1200; // Where the front of the train starts
y = 195; // Where the train's y resides

function add_cart(cart_enum) {
	
	var _cabooseEndX = x; // Default the endX to be at the beginning (if no carts currently exist)
	
	var _numCarts  = ds_list_size(cart_ids); // Get how many cart ids there are in the list
	
	// Get the end x of the last cart in the train
	if (_numCarts > 0) {
		var _cabooseId = ds_list_find_value(cart_ids,_numCarts-1); // Get the last cart id in the list
		_cabooseEndX = _cabooseId.bbox_left; // Gets the back end of the last train cart
	}
	
	// Get the cart's sprite_index before creation
	var _sideCartSprites = get_cart_sprite_from_enum(cart_enum);
	var _cartObject = get_cart_object_from_enum(cart_enum);
	
	// Create the new cart
	var _cartId = instance_create_layer(_cabooseEndX, y, "Carts", _cartObject, 
	{
		cart_enum : cart_enum, // Gives the identity of the specific cart
		side_cart_sprites: _sideCartSprites, // Gives the interior and exterior sprites of the cart
		cart_index : _numCarts // Tells the cart which place it is on a ds_list
	});
	
	// Add the new id to the end
	ds_list_add(cart_ids, _cartId);
	ds_list_add(global.currentCarts, cart_enum);
}

// Remove the cart from both the id storage and enum storage lists
function remove_cart(_cartId) {
	
	// Find the position of the cart we wish to remove
	var _index = ds_list_find_index(cart_ids, _cartId);
	ds_list_delete(cart_ids, _index);
	ds_list_delete(global.currentCarts, _index);
	
	readjust_carts();
	
	return _index;
}

// Adds the cart into both the id storage and enum storage lists
function insert_cart(_cartId, _position) {
	ds_list_insert(cart_ids, _position, _cartId);
	ds_list_insert(global.currentCarts, _position, _cartId.cart_enum);
	
	readjust_carts();
}

function readjust_carts() {
	
	// This signifies the back x of the train at any given point
	var _cabooseX = x;
	
	for (var i = 0; i < ds_list_size(cart_ids); i++) {
		
		// Get the next id in the list
		var _id = ds_list_find_value(cart_ids, i);
		
		// Set the cart's x to the caboose x
		_id.x = _cabooseX;
		
		// Reset the cart's y to the tacks
		_id.y = y;
		
		// Update that cart's bogey as well
		with (_id) {
			update_bogey_location();
			cart_index = i
		}
		
		// Add the width to the new caboose x
		_cabooseX = _id.bbox_left;
	}
}

add_cart(CARTS.ENGINE);
add_cart(CARTS.COAL);