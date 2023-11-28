
enum VIEW {
	MAIN = 0,
	MINI = 1
}

#macro SIDE_VIEW_HEIGHT 360
#macro MAP_VIEW_HEIGHT 2792
#macro MAP_VIEW_Y 552

enum CARTS {
	ENGINE = [spr_car_top_engine, sprite_get_width(spr_car_top_engine)],
	COAL = [spr_car_top_coal, sprite_get_width(spr_car_top_coal)],
	FARM = [spr_car_top_farm, sprite_get_width(spr_car_top_farm)],
	PASS = [spr_car_top_passenger, sprite_get_width(spr_car_top_passenger)],
	STORAGE = [spr_car_top_storage, sprite_get_width(spr_car_top_storage)],
	UTIL = [spr_car_top_utility, sprite_get_width(spr_car_top_utility)]
}