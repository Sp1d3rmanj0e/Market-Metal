
/// Variables given after creation:
// cart_enum - tells the cart which type it is supposed to be
// side_cart_sprites - an array in the format [interior sprite, exterior sprite] for this specific cart

// Unpack the side cart sprites
interior_sprite = side_cart_sprites[0];
exterior_sprite = side_cart_sprites[1];

sprite_index = interior_sprite;

instance_create_layer(x, y, "Cart_Covers", obj_trainCartCover,
{
	sprite_index : exterior_sprite,
	parent : id
});

cart_health = 100;
max_cart_health = cart_health;