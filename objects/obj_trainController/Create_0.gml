/// @description Insert description here
// You can write your code in this editor

// How fast we want the carts/player to move in side view of the train
player_move_speed_side_view = 5;

// Initialize an array to store the IDs of carts it creates
cart_ids = [];

// The X and Y symbolize the start of the train
// We do this so that the only thing we need to do in order to move the train is to move this object
x = 1200; // Where the front of the train starts
y = 250; // Where the train's y resides

function add_cart(cart_enum) {
	
	var _cabooseEndX = x; // Default the endX to be at the beginning (if no carts currently exist)
	
	var _numCarts  = array_length(cart_ids); // Get how many cart ids there are in the list
	
	// Get the end x of the last cart in the train
	if (_numCarts > 0) {
		var _cabooseId = cart_ids[_numCarts-1]; // Get the last cart id in the list
		_cabooseEndX = _cabooseId.bbox_left; // Gets the back end of the last train cart
	}
	
	// Get the cart's sprite_index before creation
	var _sideCartSprites = get_side_view_cart_sprite_from_enum(cart_enum);
	
	// Create the new cart
	var _cartId = instance_create_layer(_cabooseEndX, y, "Instances", obj_trainCart, 
	{
		cart_enum : cart_enum, // Gives the identity of the specific cart
		side_cart_sprites: _sideCartSprites, // Gives the interior and exterior sprites of the cart
		sprite_index : _sideCartSprites[1] // Sets the cart's exterior sprite immediately to prevent bugs
	});
	
	// Add the new id to the end
	array_push(cart_ids, _cartId);
	
	log(array_length(cart_ids));
}