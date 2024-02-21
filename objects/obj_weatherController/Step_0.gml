/// @description Insert description here
// You can write your code in this editor

previous_biome_map = current_biome_map;

with(obj_mapController) {
	other.current_biome_map = get_train_biome_map();
}

// Change the weather immediately after switching biomes
if (previous_biome_map != current_biome_map) {
	alarm[1] = 1;
}

current_biome_name = ds_map_find_value(current_biome_map, "name");

//show_debug_message("Current biome we are in: " + current_biome_name);