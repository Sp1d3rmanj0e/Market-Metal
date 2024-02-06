
// Signifies which view is being referenced
enum VIEW {
	MAIN = 0,
	MINI = 1
}

// Signifies which camera is being referenced
enum CAM {
	SIDE,
	MAP
}

// Coordinates
#macro SIDE_VIEW_HEIGHT 360
#macro MAP_VIEW_HEIGHT 2792
#macro MAP_VIEW_Y 652
#macro TRAIN_FLOOR_Y 243

#macro TRACK_SIZE 128

// Signifies which train cart is being referenced
enum CARTS {
	ENGINE,
	COAL,
	FARM,
	PASS,
	STORAGE,
	UTIL
}

// Signifies which track portion of track generation is being referenced
enum TRACK {
	PREV = 0,
	IGNORED = 1,
	CUR = 2,
	FUTURE = 3
}

// Signifies which profession is being referenced
enum PROF {
	NONE,
	WORKER,
	FIGHTER,
	FARMER,
	ATTENDANT
}

// Returns both the sprite and width of a cart enum
function get_top_cart_data(_cart) {
	
	switch(_cart) {
		case CARTS.ENGINE:		return [spr_car_top_engine, sprite_get_width(spr_car_top_engine)]
		case CARTS.COAL:		return [spr_car_top_coal, sprite_get_width(spr_car_top_coal)]
		case CARTS.FARM:		return [spr_car_top_farm, sprite_get_width(spr_car_top_farm)]
		case CARTS.PASS:		return [spr_car_top_passenger, sprite_get_width(spr_car_top_passenger)]
		case CARTS.STORAGE:		return [spr_car_top_storage, sprite_get_width(spr_car_top_storage)]
		case CARTS.UTIL:		return [spr_car_top_utility, sprite_get_width(spr_car_top_utility)]
	}
	
	// Error Return
	return [spr_car_top_engine, sprite_get_width(spr_car_top_engine)]
}