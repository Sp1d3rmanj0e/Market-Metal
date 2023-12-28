/// @description Insert description here
// You can write your code in this editor

// Initialize an array to store the IDs of carts it creates
cart_ids = [];
frontX = 1200; // Where the front of the train starts
trainY = 250; // Where the train's y resides

function add_cart(cart_enum) {
	
	var _cabooseEndX = frontX; // Default the endX to be at the beginning (if no carts currently exist)
	
	var _numCarts  = array_length(cart_ids); // Get how many cart ids there are in the list
	
	// Get the leftmost x of the caboose
	if (_numCarts > 0) {
		var _cabooseId = cart_ids[_numCarts-1]; // Get the last cart id in the list
		_cabooseEndX = _cabooseId.bbox_left; // Gets the back end of the last train cart
	}
	
	// Create the new cart
	var _cartId = instance_create_layer(_cabooseEndX, trainY, "Instances", obj_trainCart, 
	{
		cart_enum : cart_enum,
	});
	
	// Add the new id to the end
	array_push(cart_ids, _cartId);
	
	log(array_length(cart_ids));
}