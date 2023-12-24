
enum VIEW {
	MAIN = 0,
	MINI = 1
}

#macro SIDE_VIEW_HEIGHT 360
#macro MAP_VIEW_HEIGHT 2792
#macro MAP_VIEW_Y 652

#macro TRACK_SIZE 64

enum CARTS {
	ENGINE,
	COAL,
	FARM,
	PASS,
	STORAGE,
	UTIL
}

enum TRACK {
	PREV = 0,
	IGNORED = 1,
	CUR = 2,
	FUTURE = 3
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