/// @param _seed - the seed used to generate the world
/// @param _topY - the topmost border to draw the biomes
/// @param _width - the width of the biomes to draw
/// @param _height - the height of the biomes to draw
/// @param _trainX - the train offset X distance from 0 (moves the map)
/// @param _trainY - the train offset Y distance from 0 (moves the map)
/// @param _blend - blends the colors of the nearby biomes
/// @param _tileSize - how big each tile is when drawing
/// @param _scale - the "zoom" or how big biomes are
function draw_biomes(_seed, _topY, _width, _height, _trainX, _trainY, _tileSize = 128, _scale = 50000) {
	
	// Finds the offset of the screen to the grid
	// We find this so that we can readjust where we draw the biomes to create smooth instead of blocky movement
	
	// We use different methods based on whether x and y are positive or negative is that modulus doesn't work how
	// I need it to and instead of returning 127 when given -1 mod 128, I get -1, so I had to make a supplementary
	// process to do what I needed it to do instead
	var _xOff, _yOff;
	
	if (_trainX >= 0)
		_xOff = _trainX mod _tileSize;
	else
		_xOff = 128 - abs(_trainX) mod _tileSize;
	
	if (_trainY >= 0)
		_yOff = _trainY mod _tileSize;
	else
		_yOff = 128 - abs(_trainY) mod _tileSize;
	
	_width += _xOff;
	_height += _yOff;
	
	// This for loop shows the screen in which to display the biomes within it
	// _x and _y start at -_tileSize to stretch out the map enough to prevent seeing
	// and empty spots while the map is moving
	// _height and _width have _tileSize added for the same reason on the other 2 sides
	for (var _x = -_tileSize; _x < _width + _tileSize; _x+=_tileSize) {
	for (var _y = -_tileSize; _y < _height + _tileSize; _y+=_tileSize) {
		
		// Shift the map based on where the train/camera is located
		// If the train is 60px to the right, we'll draw the map shifted 60px to the right
		var _tileX = _trainX + _x;
		var _tileY = _trainY + _y;
		
		// Lock the coordinates on the tile grid
		// We do this to ensure that when we are gathering data from the noise map, 
		// the coordinates aren't shifted slightly, drawing slightly different maps every time
		var map_tileX = _tileX - _tileX mod _tileSize;
		var map_tileY = _tileY - _tileY mod _tileSize;
		
		// Get the biome that's supposed to be at that location
		// Get the biome's sprite respective to the biome given using the ds_map
		var _biomeMap = get_biome_at(_seed, map_tileX, map_tileY, _scale);
		var _biomeSprite = ds_map_find_value(_biomeMap, "sprite");
		
		// Draw the biome at the grid space
		draw_sprite_ext(_biomeSprite, 0, _x - _xOff, _y+_topY - _yOff, 1, 1, 0, c_white, 1)	
	}}
}

function draw_tracks(_xPos, _yPos, _list, _trainDistance = 500, _trackSize = 64) {
	
	draw_set_color(c_white);
	
	for (var loop = 0; loop < 2; loop++) {
	
		var X = -_xPos;
		var Y = -_yPos;
		var curAngle = 0;
		var _totalDistance = 0
		var prevX = X;
		var prevY = Y;
		
		var storeX = 0;
		var storeY = 0;
		
		for (var i = 0; i < ds_list_size(_list); i++) {
	
			// Get new track information
			var _array = ds_list_find_value(_list, i);
			var _length = _array[0];
			var _angle = _array[1];
		
			// Get angle change per track piece to end with the designated angle change
			var _angleChangePerTrack = _angle/_length;
	
			for (var j = 0; j < _length; j++) {
				_totalDistance++;
				
				// Change the angle by the amount designated
				curAngle += _angleChangePerTrack;
		
				// Find the new end point of the track
				var _xChange = lengthdir_x(_trackSize, curAngle);
				var _yChange = lengthdir_y(_trackSize, curAngle);
		
				// Shift by the x and y change
				X += _xChange;
				Y += _yChange;
				
				// Lock the coordinates on the tile grid (Doesn't work??)
				//_xPos -= _xPos mod _trackSize;
				//_yPos -= _yPos mod _trackSize;
				
				// Get the track sprite based on the angle being drawn
				var _trackSprite = spr_track_forward;
		
				var trackScale;
				if (_angleChangePerTrack == 0) or (sign(_angleChangePerTrack)) trackScale = 1;
				else trackScale = -1;
			
				// Draw a track (Only if it doesn't break into the other camera)
				var _trackWidth = 74 // sprite_get_width(spr_track_forward)
				if (Y > MAP_VIEW_Y + _trackWidth) and (X < camera_get_view_width(get_map_camera()) + _trackWidth) {
					
					// On the first loop, draw all of the tracks
					// On the second loop, draw the train's position
					if (loop == 0)
						draw_sprite_ext(_trackSprite, 0, X,Y, trackScale, 1, curAngle + 90, c_white, 1);
					else if (floor(_trainDistance/_trackSize) == _totalDistance) {
						storeX = X;
						storeY = Y;
					} else if (floor((_trainDistance + _trackSize)/_trackSize) == _totalDistance) {
						draw_sprite_ext(spr_car_top_engine, 0 , storeX, storeY, 4, 4, curAngle, c_white, 1);
					}
				}
	
				prevX = X;
				prevY = Y;
			}
		}
	}
}