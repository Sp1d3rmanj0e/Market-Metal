function draw_biomes(_leftX, _topY, _width, _height, _trainX, _trainY, _seed, _blend = 2, _tileSize = 128, _scale = BIOME_SCALE) {
	
	// Loop through every space within the set range
	for (var _x = _leftX; _x < _leftX + _width; _x+=_tileSize) {
	for (var _y = _topY; _y < _topY + _height; _y+=_tileSize) {
		
		var _biomeMap = get_biome_at(_seed, (_x + _trainX)/_tileSize, (_y + _trainY)/_tileSize, _scale);
		var _color = ds_map_find_value(_biomeMap, "color");
		
		draw_set_color(_color);
		
		for (var _b = 0; _b < _blend; _b++) {
		
			draw_set_alpha(1/power(2,_b)); // 1 = 1/2^0 = 1; 2 = 1/2^1 = 0.5; 3 = 1/2^2 = 0.25;
		
			draw_rectangle(
			_x-_tileSize*_b, 
			max(_y-_tileSize*_b, _topY), 
			_x+_tileSize*(_b+1), 
			_y+_tileSize*(_b+1), false);
			draw_set_alpha(1);
		}
	}}
}