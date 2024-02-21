/// @description Insert description here
// You can write your code in this editor

var _biomeMap;
with (obj_mapController) {
	_biomeMap = get_train_biome_map();
}

current_biome_name = ds_map_find_value(_biomeMap, "name");

// Crossfade any new biome sprites
if (current_biome_sprite != previous_biome_sprite) {
	fade += fade_transition_speed;
	
	// Once the transition is complete,
	// 1) Reset fade to prepare for the next transition
	// 2) Copy the current biome sprite to the previous biome sprite
	if (fade >= 1) {
		fade = 0;
		previous_biome_sprite = current_biome_sprite;
	}
}