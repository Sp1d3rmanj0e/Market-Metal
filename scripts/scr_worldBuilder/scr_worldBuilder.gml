/// @param _seed - the seed used to generate the world
/// @param _topY - the topmost border to draw the biomes
/// @param _width - the width of the biomes to draw
/// @param _height - the height of the biomes to draw
/// @param _trainX - the train offset X distance from 0 (moves the map)
/// @param _trainY - the train offset Y distance from 0 (moves the map)
/// @param _blend - blends the colors of the nearby biomes
/// @param _tileSize - how big each tile is when drawing
/// @param _scale - the "zoom" or how big biomes are
function draw_biomes(_seed, _topY, _width, _height, _trainX, _trainY, _blend = 2, _tileSize = 128, _scale = 50000) {
	
	// This for loop shows the screen in which to display the biomes within it
	for (var _x = 0; _x < _width; _x+=_tileSize) {
	for (var _y = 0; _y < _height; _y+=_tileSize) {
		
		// Get the actual X and Y coordinate of the train
		var _tileX = _trainX + _x;
		var _tileY = _trainY + _y;
		
		// Lock the coordinates on the tile grid
		_tileX -= _tileX mod _tileSize;
		_tileY -= _tileY mod _tileSize;
		
		// Get and set the biome color
		var _biomeMap = get_biome_at(_seed, _tileX, _tileY, _scale);
		var _color = ds_map_find_value(_biomeMap, "color");
		draw_set_color(_color);
		
		// Loop for every blend intensity level
		for (var _b = 0; _b < _blend; _b++) {
		
			draw_set_alpha(1/power(2,_b)); // 1 = 1/2^0 = 1; 2 = 1/2^1 = 0.5; 3 = 1/2^2 = 0.25;
			
			// Draws similarly colored tiles with the alpha 
			// dissipating as it gets further from the original tile
			draw_rectangle(
			_x-_tileSize*_b, 
			max((_y+_topY)-_tileSize*_b, _topY), 
			_x+_tileSize*(_b+1), 
			_y+_topY+_tileSize*(_b+1), false);
			draw_set_alpha(1);
		}
	}}
}

function generate_track_section(_seed, _startX, _startY, _tileSize) {
	
	
}