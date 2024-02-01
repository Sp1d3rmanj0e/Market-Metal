/// @description Insert description here
// You can write your code in this editor

var _biomeMap;
with(obj_mapController) {
	_biomeMap = get_center_of_camera_biome_map();
}

current_biome_name = ds_map_find_value(_biomeMap, "name");

//show_debug_message("Current biome we are in: " + current_biome_name);