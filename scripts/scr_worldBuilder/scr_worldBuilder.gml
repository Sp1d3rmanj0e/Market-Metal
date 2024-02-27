/// @param _seed - the seed used to generate the world
/// @param _topY - the topmost border to draw the biomes
/// @param _width - the width of the biomes to draw
/// @param _height - the height of the biomes to draw
/// @param _camX - the train offset X distance from 0 (moves the map)
/// @param _camY - the train offset Y distance from 0 (moves the map)
/// @param _blend - blends the colors of the nearby biomes
/// @param _tileSize - how big each tile is when drawing
/// @param _scale - the "zoom" or how big biomes are
function draw_biomes(_seed, _topY, _width, _height, _camX, _camY, _tileSize = 256, _scale = BIOME_SCALE) {
	
	_topY = MAP_VIEW_Y;
	_height = MAP_VIEW_HEIGHT;
	
	var _bottomY = _height + _topY;
	
	for (var _x = -_tileSize; _x < _width + _tileSize;	 _x += _tileSize) {
	for (var _y = _topY;	  _y < _bottomY + _tileSize; _y += _tileSize) {
		
		var _mapX = _x + _camX;
		var _mapY = _y + _camY;
		
		var _mapTileX = _mapX - working_mod(_mapX, _tileSize);
		var _mapTileY = _mapY - working_mod(_mapY, _tileSize);
		
		var _biomeMap = get_biome_at(_seed, _mapTileX, _mapTileY, _scale);
		var _biomeSprite = ds_map_find_value(_biomeMap, "sprite");
		
		/// Drawing lakes
		//var _lakeBiomeMap = get_biome_at(_seed*752.123, _mapTileX, _mapTileY, _scale/12);
		//var _lakeBiomeSprite = ds_map_find_value(_lakeBiomeMap, "name");
		
		//if (_lakeBiomeSprite == "Deep Ocean") or (_lakeBiomeSprite == "Mid Ocean") or (_lakeBiomeSprite == "Shallow Ocean") {
		//	draw_sprite_ext(spr_river, 0, _mapTileX - _camX, _mapTileY - _camY, 2, 2, 0, c_white, 1);
		//	draw_line(_mapTileX, _mapTileY, mouse_x, mouse_y);
		//} else {
		draw_sprite_ext(_biomeSprite, 0, _mapTileX - _camX, _mapTileY - _camY, 2, 2, 0, c_white, 1);
		//}
	}}
}

// Draw the tracks on the map 
// Returns an array with equidistant vectors representing an X and Y location and the angle it is facing
function draw_tracks(_xCamPos, _yCamPos, _list, _startX = 0, _startY = 0, curAngle = 0, _returnMap = false, _trackSize = TRACK_SIZE) {
	
	// Store each node/vector (X, Y, angle) into an array so that we can accurately draw trains on the track
	// while also maintaining clean and fast code
	var _vectors = [];
	var X = -_xCamPos + _startX;
	var Y = -_yCamPos + _startY;
	var _totalDistance = 0;
	var prevX = X;
	var prevY = Y;
		
	// Stores the location of the train
		
	// We store the train's X and Y because in order to best draw the train, we want to draw it
	// facing the next track's angle, which we can get after another loop 
	// (which is past where the train should be drawn).  After we get that
	// data, we then draw the train using these coordinates
		
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
			if (Y > MAP_VIEW_Y - _trackWidth) and (X < camera_get_view_width(get_map_camera()) + _trackWidth) {
				
				// Ensure a consistently random track sprite based on location
				random_set_seed((X + map_cam_x)*0.867 + (Y+map_cam_y) * 1.54);
				
				// Draw the tracks
				draw_sprite_ext(_trackSprite, irandom_range(2, 9), X,Y, trackScale, 1, curAngle + 90, c_white, 1);
				//draw_text_transformed(X + 10, Y + 10, "(" + string(map_cam_x + X) + ", " + string(map_cam_y + Y) + ")", 5, 5, 0);
			}
			
			// Store the vector in the vectors array
			array_push(_vectors, [X, Y, curAngle]);
	
			prevX = X;
			prevY = Y;
		}
	}
	
	var vector_map = ds_map_create();
	ds_map_add(vector_map, "vectors", _vectors);
	ds_map_add(vector_map, "endX", X);
	ds_map_add(vector_map, "endY", Y);
	ds_map_add(vector_map, "endAngle", curAngle);

	if (_returnMap) {
		return vector_map
	} else {
		ds_map_destroy(vector_map);
		return
	}
}

// Draw the train on the track using the vectors array generated with the draw_tracks() function
function draw_train_cart(_vectors = [[0,0,0]], _trainDistance = 0, _cartSprite = spr_car_top_engine, _updateTrainPosition = false, _trackSize = TRACK_SIZE) {
	
	// Find how many vectors there are (to prevent errors)
	var _vectorsLength = array_length(_vectors);
	
	// Find which vectors to get data from based on the train's location
	var _floorVectorLoc = clamp(floor(_trainDistance/_trackSize), 0, _vectorsLength-1); // Used to retrieve base X and Y location and angle
	var _ceilVectorLoc = min(_floorVectorLoc+1, _vectorsLength-1); // Used to get the angle the train is turning into
	
	// Get the X, Y, and angle of the nearest track vectors
	var _baseVector = _vectors[_floorVectorLoc];
		var _baseX = _baseVector[0];
		var _baseY = _baseVector[1];
		var _baseAngle = _baseVector[2];
		
	var _nextVector = _vectors[_ceilVectorLoc];
		var _nextAngle = _nextVector[2];
	
	// Get how far away the train is from its base vector
	var _distanceFromBaseVector = _trainDistance mod _trackSize;
	
	// Lerp the angle of the train (to create a realistic turning animation)
	var _trainAngle = lerp(_baseAngle, _nextAngle, _distanceFromBaseVector/_trackSize);
	
	// Get the X and Y location of the train based on
	// how far it is away from the base vector and it's train Angle
	var _camX = _baseX + lengthdir_x(_distanceFromBaseVector, _trainAngle);
	var _camY = _baseY + lengthdir_y(_distanceFromBaseVector, _trainAngle);
	
	// Don't draw the train if it goes out of view bounds
	var _trackWidth = 74;
	
	if (_camY > MAP_VIEW_Y + _trackWidth) and (_camX < camera_get_view_width(get_map_camera()) + _trackWidth) {
		draw_sprite_ext(_cartSprite, 0,_camX, _camY, 4, 4, _trainAngle, c_white, 1);
	}
	
	// Only activates for the first train cart in the line (the engine)
	if (_updateTrainPosition) {
		global.train_x = _camX + obj_mapController.map_cam_x;
		global.train_y = _camY + obj_mapController.map_cam_y;
		//draw_text_transformed(_camX, _camY + 40, "Current Passengers: " + string(global.numPassengers), 10, 10, 0);
	}
	

	
	// If the train has reached the end, return true
	if (_ceilVectorLoc+1 == _vectorsLength) {
		return true;	
	}
}

function draw_train(_vectors = [[0,0,0]], _carts, _frontTrainDistance = 0, _trackSize = 64) {
	
	var _trainScale = 4;
	
	// Create a mutable variable to calculate the distances of every cart
	var _cartDistance = _frontTrainDistance;
	
	// Initialize this variable - if the first cart has reached the end,
	// at the end of this function, it will return true, telling the
	// map controller as a result
	var _trainReachedEnd = false;
	
	// Loop for every cart
	for (var i = 0; i < ds_list_size(_carts); i++) {
		
		// Get the cart sprite and width
		var _cartData = get_top_cart_data(ds_list_find_value(_carts, i));
		
		// Extract cart sprite and width
		var _cartTopSprite = _cartData[0];
		var _cartTopLength = _cartData[1];
		
		// The first cart in the train should not subtract it's width
		// as it doesn't need to adjust for any carts in front of it
		if (i != 0)
			 // We subtract 25% of the current cart's width to account for the 
			 // distance between the origin and the front of the cart
			_cartDistance -= _cartTopLength * (0.25 * _trainScale);
		
		// Draw the cart
		// We only update train position for the first cart because we want the
		// base position to be the front of the train, not the back (also wastes processing power)
		if (i == 0)
			_trainReachedEnd = draw_train_cart(_vectors, _cartDistance, _cartTopSprite, true);
		else
			draw_train_cart(_vectors, _cartDistance, _cartTopSprite, false);
		
		// Move backwards equal to half the width of the cart
		
		// We subtract 75% of the front cart's width to account for the
		// distance between the origin and the back of the cart in front
		_cartDistance -= _cartTopLength * (0.75 * _trainScale);
		
		// Add spacing between each cart
		_cartDistance -= 5;
		
		/** How the origin calculations work:
		
		         25% current cart width
				  |     75% front cart width   
		         <--> <-------->
		[           ] [           ]
		[== == ==X==] [== == ==X==]
		[        ^  ] [        ^  ]
		         ^             Origin (3/4ths in on the front cart)
		         Origin (3/4ths in on current cart)
				 
		Totals to the full distance between the front cart's origin and the current cart's origin
		*/
		
		// If this returns true, it will stop the train from moving and
		// will load the next chunks
	}
	
	return _trainReachedEnd;
}