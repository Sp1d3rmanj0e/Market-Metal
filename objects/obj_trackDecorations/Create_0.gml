/// @description Insert description here
// You can write your code in this editor

// Stores the previous biome sprite for crossfade purposes
previous_biome_sprite = spr_error;

fade = 0;
fade_transition_speed = 0.03;

current_biome_sprite = spr_error;

current_biome_name = "None";

function get_decor_sprite_from_biome(_biomeName) {
	switch(_biomeName) {
		case "Beach":				return spr_beach_tracks;
		case "Burnt Forest":		return spr_burnt_forest_tracks;
		case "Plains":				return spr_plains_tracks;
		case "Forest":				return spr_forest_tracks;
		case "Maple Forest":		return spr_maple_forest_tracks;
		case "Swamp":				return spr_swamp_tracks;
		case "Light Mountains":		return spr_light_mountain_tracks;
		case "Broken City":				return spr_city_tracks;
		case "Old Growth Forest":	return spr_old_growth_forest_tracks;
		case "Snow":				return spr_snow_tracks;
		case "Tropical Forest":		return spr_tropical_forest_tracks;
		case "Salt Flats":			return spr_salt_flats_tracks;
		case "Desert":				return spr_desert_tracks;
		case "Mesa":				return spr_mesa_tracks;
		case "Broken Theme Park":	return spr_theme_park_tracks;
		case "Heavy Mountains":		return spr_heavy_mountain_tracks;
		case "Deep Ocean": 
		case "Mid Ocean": 
		case "Shallow Ocean": 
		case "River":				return spr_water_tracks;
	}
	return spr_desert_tracks;
}