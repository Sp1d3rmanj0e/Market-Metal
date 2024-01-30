

/// Variables given after creation:
// cart_enum - tells the cart which type it is supposed to be
// side_cart_sprites - an array in the format [interior sprite, exterior sprite] for this specific cart
// sprite_index - defaulting to the exterior form of the cart


// Create the wheel animator
if (!instance_exists(obj_wheelAnimator)) instance_create_layer(0, 0, "Instances", obj_wheelAnimator);

// Start the alarm
alarm[0] = 1;