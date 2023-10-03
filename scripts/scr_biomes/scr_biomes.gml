// Constant Data
enum BIOME {
	HUMID_LEVELS = 5, // There are 5 different levels of humidity
	INLAND_LEVELS = 4, // There are 4 different levels of Inlandness
	NUM_BIOMES = 20
}

#macro BIOME_SCALE 0.5

// Easily and simply adds all the biome data into a single map
/// @param _num - the number that corresponds to a spot on the tileset
/// @param _name - the name of the biome (string)
/// @param _color - the associated color with the biome
/// @param _resources[] - an array of all resources that can spawn in 
//						  the biome and how likely they are to spawn
/// @param _structures[] - an array of all the structures that can
//						   spawn in the biome and how likely they are
//						   to spawn
/// @param _events - an array of natural events (like aurora borealis) 
//					 that can occur in the biome
/// @param _difficulty - a number that tells the game what difficulty of enemies to spawn in that biome
/// @returns a ds_map() of all of these data points
function create_biome_data(_num = -1, _name = "null", _color = c_black, _resources = [], _structures = [], _events = [], _difficulty = 1) {
	var _map = ds_map_create();
	ds_map_add(_map, "num", _num)
	ds_map_add(_map, "name", _name);
	ds_map_add(_map, "color", _color);
	ds_map_add(_map, "resources", _resources);
	ds_map_add(_map, "structures", _structures);
	ds_map_add(_map, "events", _events);
	ds_map_add(_map, "difficulty", _difficulty);
	return _map;
}

// Execute only once to add all biome data into global.biomes
function load_biomes_into_memory() {

#region biome creation
Deep_Ocean		  = create_biome_data(1,  "Deep Ocean",			c_navy,				 , , , 3);
Mid_Ocean		  = create_biome_data(2,  "Mid Ocean",			c_blue,				 , , , 2);
Shallow_Ocean	  = create_biome_data(3,  "Shallow Ocean",		rgb(1, 171, 239),	 , , , 1);
River			  = create_biome_data(4,  "River",				c_aqua,				 , , , 1);
Beach			  = create_biome_data(5,  "Beach",				rgb(224, 228, 87),	 , , , 1);
Burnt_Forest	  = create_biome_data(7,  "Burnt Forest",		c_red,				 , , , 2);
Plains			  = create_biome_data(8,  "Plains",				rgb(236, 238, 143),	 , , , 2);
Forest			  = create_biome_data(9,  "Forest",				c_green,			 , , , 2);
Maple_Forest	  = create_biome_data(10, "Maple Forest",		rgb(165,57,5),		 , , , 1);
Swamp			  = create_biome_data(11, "Swamp", 				rgb(191,108,30),	 , , , 1);
Light_Mountains	  = create_biome_data(13, "Light Mountains",	c_gray,				 , , , 1);
Broken_City		  = create_biome_data(14, "Broken City",		c_fuchsia,			 , , , 1);
//Tundra		  = create_biome_data(14, "Tundra",				rgb(100,199,189),	 , , , 1);
Old_Growth_Forest = create_biome_data(15, "Old Growth Forest",	c_maroon,			 , , , 1);
Snow			  = create_biome_data(16, "Snow",				rgb(75,166,232),	 , , , 1);
Tropical_Forest	  = create_biome_data(17, "Tropical Forest",	rgb(154,211,68),	 , , , 1);
Salt_Flats		  = create_biome_data(19, "Salt Flats",			rgb(154,211,68),     , , , 1);
Desert			  = create_biome_data(20, "Desert",				c_yellow,			 , , , 1);
Mesa			  = create_biome_data(21, "Mesa",				rgb(245,159,47),	 , , , 1);
Broken_Theme_Park = create_biome_data(22, "Broken Theme Park",	rgb(235,107,32),	 , , , 1);
Heavy_Mountains	  = create_biome_data(23, "Heavy Mountains",	c_dkgray,			 , , , 1);
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
function get_biome(_humidity, _inlandness) {
	
	var _humidScale  = clamp(round(_humidity * 4), 0, 4);
	
	var _inlandScale = clamp(round(_inlandness * 3), 0, 3);
	
	return global.biomes[_inlandScale][_humidScale];
}

/// @param _value - the value to clamp between 0 and 1
/// @param _center - a value between 0 and 1.  When 0, clamps to 0.5.  When 1, does not clamp at all
function clamp_center(_value, _center) {
	clamp(_value,lerp(0, 0.5, _center),lerp(1, 0.5, _center));
}

// Increases the bias towards the centermost biomes as _center increases in value
// This function was designed to garuantee that the early biomes will spawn near 
// easier biomes and get harder as the player progresses
// If center = 1, garuanteed be 0.5, 0.5
// If center = 0, could be anywhere from 0-1
function get_biome_distance(_humidity, _inlandness, _center) {
	_humidity	= clamp_center(_humidity, _center);
	_inlandness = clamp_center(_inlandness, _center);
	
	return get_biome(_humidity, _inlandness);
}

// Returns the inlandness of a coordinate, biased by it's centeredness
function noise_scale(_seed, _x, _y, _scale = BIOME_SCALE) {
	return noise_octave(_seed, _x/_scale, _y/_scale);
}

/// @param _seed - the seed of the map the player is on
/// @param _tileX - the x location of the requested tile
/// @param _tileY - the y location of the requested tile
/// @param _center - a scale from 0-1, with 0 allowing for the hardest biomes
//					 and 1 allowing only the easiest biomes
/// @returns a ds_map() of the biome
function get_biome_at_tile_distance(_seed, _tileX, _tileY, _center) {
	var _inlandness = noise_scale(_seed, _tileX, _tileY);
	var _humidity	= noise_scale(_seed+1, _tileX, _tileY);
	get_biome_distance(_inlandness, _humidity, _center);
}