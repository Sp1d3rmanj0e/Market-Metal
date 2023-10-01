// Constant Data
enum BIOME {
	HUMID_LEVELS = 5, // There are 5 different levels of humidity
	INLAND_LEVELS = 4, // There are 4 different levels of Inlandness
	NUM_BIOMES = 20
}

// Easily and simply adds all the biome data into a single map
function create_biome_data(_name = "null", _color = c_black, _resources = [], _structures = [], _events = [], _difficulty = 1) {
	var _map = ds_map_create();
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
Deep_Ocean		  = create_biome_data("Deep Ocean",			c_navy,				 , , , 3);
Mid_Ocean		  = create_biome_data("Mid Ocean",			c_blue,				 , , , 2);
Shallow_Ocean	  = create_biome_data("Shallow Ocean",		rgb(1, 171, 239),	 , , , 1);
River			  = create_biome_data("River",				c_aqua,				 , , , 1);
Beach			  = create_biome_data("Beach",				rgb(224, 228, 87),	 , , , 1);
Burnt_Forest	  = create_biome_data("Burnt Forest",		c_red,				 , , , 2);
Plains			  = create_biome_data("Plains",				rgb(236, 238, 143),	 , , , 2);
Forest			  = create_biome_data("Forest",				c_green,			 , , , 2);
Maple_Forest	  = create_biome_data("Maple Forest",		rgb(165,57,5),		 , , , 1);
Swamp			  = create_biome_data("Swamp", 				rgb(191,108,30),	 , , , 1);
Light_Mountains	  = create_biome_data("Light Mountains",	c_gray,				 , , , 1);
Broken_City		  = create_biome_data("Broken City",		c_fuchsia,			 , , , 1);
//Tundra		  = create_biome_data("Tundra",				rgb(100,199,189),	 , , , 1);
Old_Growth_Forest = create_biome_data("Old Growth Forest",	c_maroon,			 , , , 1);
Snow			  = create_biome_data("Snow",				rgb(75,166,232),	 , , , 1);
Tropical_Forest	  = create_biome_data("Tropical Forest",	rgb(154,211,68),	 , , , 1);
Salt_Flats		  = create_biome_data("Salt Flats",			rgb(154,211,68),     , , , 1);
Desert			  = create_biome_data("Desert",				c_yellow,			 , , , 1);
Mesa			  = create_biome_data("Mesa",				rgb(245,159,47),	 , , , 1);
Broken_Theme_Park = create_biome_data("Broken Theme Park",	rgb(235,107,32),	 , , , 1);
Heavy_Mountains	  = create_biome_data("Heavy Mountains",	c_dkgray,			 , , , 1);
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