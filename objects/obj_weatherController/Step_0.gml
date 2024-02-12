/// @description Insert description here
// You can write your code in this editor

with(obj_mapController) {
	other.current_biome_map = get_center_of_camera_biome_map();
}

current_biome_name = ds_map_find_value(current_biome_map, "name");

//show_debug_message("Current biome we are in: " + current_biome_name);