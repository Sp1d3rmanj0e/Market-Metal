// Constant Data
enum BIOME {
	HUMID_LEVELS = 5, // There are 5 different levels of humidity
	INLAND_LEVELS = 4, // There are 4 different levels of Inlandness
	NUM_BIOMES = 20
}

#macro BIOME_SCALE 50000

// Easily and simply adds all the biome data into a single map
/// @param _num - the number that corresponds to a spot on the tileset
/// @param _name - the name of the biome (string)
/// @param _color - the associated color with the biome
/// @param _resources[[RESOURCE, % Chance spawn]] - an array of all resources that can spawn in 
//						  the biome and how likely they are to spawn
/// @param _structures[] - an array of all the structures that can
//						   spawn in the biome and how likely they are
//						   to spawn
/// @param _events - an array of natural events (like aurora borealis) 
//					 that can occur in the biome
/// @param _difficulty - a number that tells the game what difficulty of enemies to spawn in that biome
/// @param _weather (dictionary) - see create_weather_profile() description
/// @returns a ds_map() of all of these data points
function create_biome_data(_num = -1, _name = "null", _color = c_black, _sprite = spr_error, _resources = [], _structures = [], _events = [], _difficulty = 1, _weather = [[WEATHER.CLEAR, 1]]) {
	var _map = ds_map_create();
	ds_map_add(_map, "tNum", _num)
	ds_map_add(_map, "name", _name);
	ds_map_add(_map, "color", _color);
	ds_map_add(_map, "sprite", _sprite);
	ds_map_add(_map, "resources", _resources);
	ds_map_add(_map, "structures", _structures);
	ds_map_add(_map, "events", _events);
	ds_map_add(_map, "difficulty", _difficulty);
	ds_map_add(_map, "weather", _weather);
	return _map;
}

// Creates a Ds_map containing the chances of any weather event happening
/// Created with help from https://dev.to/jacktt/understanding-the-weighted-random-algorithm-581p
/// @returns a map with keys "values" and "weights", which return 2 arrays storing a weather event
//			 and the weight/chance of that happening
function create_weather_profile(_clearWeight, _rainWeight, _snowWeight, _sandWeight) {
	
	var _values = [WEATHER.CLEAR, WEATHER.RAIN, WEATHER.SNOW, WEATHER.SAND];
	var _weights = [_clearWeight, _rainWeight, _snowWeight, _sandWeight]
	
	var _map = {
		"values" : _values,
		"weights" : _weights
	}
	
	return _map
}

// Execute only once to add all biome data into global.biomes
function load_biomes_into_memory() {

#region biome creation
Deep_Ocean		  = create_biome_data(1,  "Deep Ocean",			c_navy,				 spr_deep_ocean			,[] , , 3, 1, create_weather_profile(49, 49, 2, 0));
Mid_Ocean		  = create_biome_data(2,  "Mid Ocean",			c_blue,				 spr_mid_ocean			,[] , , 2, 1, create_weather_profile(48, 48, 4, 0));
Shallow_Ocean	  = create_biome_data(3,  "Shallow Ocean",		rgb(1, 171, 239),	 spr_shallow_ocean		,[] , , 1, 1, create_weather_profile(46, 46, 8, 0));
River			  = create_biome_data(4,  "River",				c_aqua,				 spr_river				,[] , , 1, 1, create_weather_profile(46, 46, 8, 0));
Beach			  = create_biome_data(5,  "Beach",				rgb(224, 228, 87),	 spr_beach				,[[RESOURCE.PALM_TREE, 6]] , , 1, 1, create_weather_profile(48, 65, 1, 0));
Burnt_Forest	  = create_biome_data(7,  "Burnt Forest",		c_red,				 spr_burnt_forest		,[[RESOURCE.BURNT_TREE, 5]] , , 2, 1, create_weather_profile(90, 10, 0, 0));
Plains			  = create_biome_data(8,  "Plains",				rgb(236, 238, 143),	 spr_plains				,[[RESOURCE.OAK_TREE, 2]] , , 2, 1, create_weather_profile(70, 30, 8, 0));
Forest			  = create_biome_data(9,  "Forest",				c_green,			 spr_forest				,[[RESOURCE.OAK_TREE, 5], [RESOURCE.PINE_TREE, 3], [RESOURCE.OLD_TREE, 1]] , , 2, 1, create_weather_profile(120, 30, 4, 0));
Maple_Forest	  = create_biome_data(10, "Maple Forest",		rgb(165,57,5),		 spr_maple_forest		,[[RESOURCE.MAPLE_TREE, 10]] , , 1, 1, create_weather_profile(100, 40, 4, 0));
Swamp			  = create_biome_data(11, "Swamp", 				rgb(191,108,30),	 spr_swamp				,[[RESOURCE.SWAMP_TREE, 6]] , , 1, 1, create_weather_profile(40, 80, 2, 0));
Light_Mountains	  = create_biome_data(13, "Light Mountains",	c_gray,				 spr_light_mountains	,[] , , 1, 1, create_weather_profile(10, 25, 25, 0));
Broken_City		  = create_biome_data(14, "Broken City",		c_fuchsia,			 spr_city				,[[RESOURCE.RUBBLE, 12], [RESOURCE.CRANE, 1], [RESOURCE.SKYSCRAPER1, 3], [RESOURCE.SKYSCRAPER2, 3]] , , 1, 1, create_weather_profile(50, 20, 2, 0));
//Tundra		  = create_biome_data(14, "Tundra",				rgb(100,199,189),	 spr_					,[] , , 1);
Old_Growth_Forest = create_biome_data(15, "Old Growth Forest",	c_maroon,			 spr_old_growth_forest	,[[RESOURCE.OLD_TREE, 7]] , , 1, 1, create_weather_profile(48, 48, 4, 0));
Snow			  = create_biome_data(16, "Snow",				rgb(75,166,232),	 spr_snow				,[[RESOURCE.PINE_TREE, 12]] , , 1, 1, create_weather_profile(5, 5, 100, 0));
Tropical_Forest	  = create_biome_data(17, "Tropical Forest",	rgb(154,211,68),	 spr_tropical_forest	,[[RESOURCE.TROPICAL_TREE, 5]] , , 1, 1, create_weather_profile(15, 90, 0, 0));
Salt_Flats		  = create_biome_data(19, "Salt Flats",			rgb(154,211,68),     spr_salt_flats			,[[RESOURCE.IRON_ORE, 10]] , , 1, 1, create_weather_profile(100, 1, 1, 0));
Desert			  = create_biome_data(20, "Desert",				c_yellow,			 spr_desert				,[[RESOURCE.CACTUS, 10]] , , 1, 1, create_weather_profile(60, 1, 0, 40));
Mesa			  = create_biome_data(21, "Mesa",				rgb(245,159,47),	 spr_mesa				,[[RESOURCE.CACTUS, 7]] , , 1, 1, create_weather_profile(80, 5, 4, 20));
Broken_Theme_Park = create_biome_data(22, "Broken Theme Park",	rgb(235,107,32),	 spr_theme_park			,[] , , 1, 1, create_weather_profile(50, 50, 2, 5));
Heavy_Mountains	  = create_biome_data(23, "Heavy Mountains",	c_dkgray,			 spr_heavy_mountains	,[[RESOURCE.GOLD_ORE, 5], [RESOURCE.PINE_TREE, 15]] , , 1, 1, create_weather_profile(20, 40, 50, 0));
#endregion biome creation

// A 2D Lookup Table based on humidity and inlandness.
// RETURNS a ds_map of the given biome
global.biomes =
[
[[Deep_Ocean],		[Mid_Ocean],	[Shallow_Ocean],	[River],				[Beach]],
[[Burnt_Forest],	[Plains],		[Forest],			[Maple_Forest],			[Swamp]],
[[Light_Mountains],	[Broken_City],	[Old_Growth_Forest],[Snow],					[Tropical_Forest]],
[[Salt_Flats],		[Desert],		[Mesa],				[Broken_Theme_Park],	[Heavy_Mountains]]
]
}

// Uses both 0-1 scales and finds the matching biome in the biomes array
/* Ex.
 * _humidity = 0.35   -> 0.35 * (5-1) = 1.4  -[Round]-> 1
 * _inlandness = 0.76 -> 0.76 * (4-1) = 2.28 -[Round]-> 2
 *
 * Humidity = Level 1
 * Inlandness = Level 2
 *
 * According to the biomes array, it would return Broken_City
 */
function get_biome_map(_humidity, _inlandness) {
	
	var _humidScale  = clamp(round(_humidity * (BIOME.HUMID_LEVELS-1)), 0,  (BIOME.HUMID_LEVELS-1));
	
	var _inlandScale = clamp(round(_inlandness * (BIOME.INLAND_LEVELS-1)), 0, (BIOME.INLAND_LEVELS-1));
	
	return global.biomes[_inlandScale][_humidScale][0];
}

// Simplifies the noise function to already take into account the scale
// of the map.  If the _scale value is larger, the map will have larger biomes (and V/V)
function noise_scale(_seed, _x, _y, _scale = BIOME_SCALE) {
	return noise_octave(_seed, _x/_scale, _y/_scale);
}

/// @param _seed - the seed of the map the player is on
/// @param _x - the x location of the requested spot on the map
/// @param _y - the y location of the requested spot on the map
/// @param _scale - OPTIONAL - larger scale = more zoomed in on the map = larger biomes
/// @returns a ds_map() of the biome
function get_biome_at(_seed, _x, _y, _scale = BIOME_SCALE) {
	var _inlandness = noise_scale(_seed, _x, _y, _scale);
	var _humidity	= noise_scale(_seed+1, _x, _y, _scale);
	return get_biome_map(_humidity, _inlandness);
}

// Does the same thing as the above function, but locks each coordinate to a grid
// to promote consistency betweem different parts of the code
function get_biome_at_tile(_seed, _x, _y, _tileSize, _scale = BIOME_SCALE) {
	
	// Lock to nearest grid
	var _mapTileX = _x - working_mod(_x, _tileSize);
	var _mapTileY = _y -  working_mod(_y, _tileSize);
	
	// Get the biome
	return get_biome_at(_seed, _mapTileX, _mapTileY, _scale);
}

// How mod actually works
function working_mod(_value, _mod) {
	if (_value >= 0) {
		return _value mod _mod;
	} else {
		return _mod - abs(_value) mod _mod;
	}
}