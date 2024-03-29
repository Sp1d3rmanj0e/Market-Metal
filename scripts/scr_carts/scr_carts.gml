

// Returns an array of that cart's sprites in the format [Inside Sprite, Outside Sprite]
// *Note - some sprites are duplicates.  These ones don't have only one state
function get_cart_sprite_from_enum(cart_enum) {
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

function get_cart_object_from_enum(cart_enum) {
	switch(cart_enum) {
		case CARTS.ENGINE:  return obj_trainCartEngine;
		case CARTS.COAL:    return obj_trainCartCoal;
		case CARTS.FARM:    return obj_trainCartFarm;
		case CARTS.PASS:    return obj_trainCartPassenger;
		case CARTS.STORAGE: return obj_trainCartStorage;
		case CARTS.UTIL:    return obj_trainCartUtility;
	}
	
	return obj_trainCart;
	log("There was an error when attempting to retrieve side view train sprites");
}

function get_cart_max_capacity(cart_enum) {
	switch(cart_enum) {
		case CARTS.ENGINE: return 0;
		case CARTS.COAL: return 0;
		case CARTS.FARM: return 1;
		case CARTS.PASS: return 5;
		case CARTS.STORAGE: return 0;
		case CARTS.UTIL: return 1;
	}
	
	return [spr_error, spr_error];
	log("There was an error when attempting to retrieve side view train sprites");
}