/// @description Random tick for a new weather event

// Get the chances of a given weather event from occuring
var _weatherDict = ds_map_find_value(current_biome_map, "weather");

// Unpack the dictionary
var _values = _weatherDict[$ "values"];
var _weights = _weatherDict[$ "weights"];

var _nextWeatherEvent = get_value_from_weights(_values, _weights);

global.currentWeather = _nextWeatherEvent;

log(string(global.currentWeather));

alarm[1] = random_range(7, 14) * room_speed;