

/// Variables given after creation:
// cart_enum - tells the cart which type it is supposed to be
// side_cart_sprites - an array in the format [interior sprite, exterior sprite] for this specific cart
// sprite_index - defaulting to the exterior form of the cart


// Create the wheel animator
if (!instance_exists(obj_wheelAnimator)) instance_create_layer(0, 0, "Instances", obj_wheelAnimator);

// Start the alarm
alarm[0] = 1;

// Create the entrance/exit object if the cart is an engine
if (cart_enum == CARTS.ENGINE)
	instance_create_layer(x-250, TRAIN_FLOOR_Y, "Instances", obj_trainExit,
	{
		engine_id : id
	});