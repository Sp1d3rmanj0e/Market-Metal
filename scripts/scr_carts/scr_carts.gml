

// Returns an array of that cart's sprites in the format [Inside Sprite, Outside Sprite]
// *Note - some sprites are duplicates.  These ones don't have only one state
function get_side_view_cart_sprite_from_enum(cart_enum) {
	switch(cart_enum) {
		case CARTS.ENGINE: return [spr_train_engine, spr_train_engine];
		case CARTS.COAL: return [spr_coal_car, spr_coal_car];
		case CARTS.FARM: return [spr_farm_car, spr_farm_car];
		case CARTS.PASS: return [spr_passengerCarInside, spr_passengerCarOutside];
		case CARTS.STORAGE: return [spr_storageCarInside, spr_storageCarOutside];
		case CARTS.UTIL: return [spr_utilityCarInside, spr_utilityCarOutside];
	}
	
	return [spr_error, spr_error];
	log("There was an error when attempting to retrieve side view train sprites");
}