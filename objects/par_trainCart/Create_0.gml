
/// Variables given after creation:
// cart_enum - tells the cart which type it is supposed to be
// side_cart_sprites - an array in the format [interior sprite, exterior sprite] for this specific cart

bogey_id = noone; // Stores the ids of the train bogey

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

cart_health = 100;
max_cart_health = cart_health;

function update_bogey_location() {
	with(bogey_id) {
		x = other.x;
		y = other.y;
	}
}