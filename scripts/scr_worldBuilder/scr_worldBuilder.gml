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
		
		// Get and set the biome sprite
		var _biomeMap = get_biome_at(_seed, _tileX, _tileY, _scale);
		var _biomeSprite = ds_map_find_value(_biomeMap, "sprite");
		
		// Loop for every blend intensity level
		// <<<<<<<<<<<<<<<<<< BLEND IS UNUSED AT THE MOMENT
		//for (var _b = 0; _b < _blend; _b++) {
			
			
		//}
		
		draw_sprite_ext(_biomeSprite, 0, _x, _y+_topY, 1, 1, 0, c_white, 1)	
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