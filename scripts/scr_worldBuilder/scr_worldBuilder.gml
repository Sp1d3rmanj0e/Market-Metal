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

// Draw the tracks on the map 
// Returns an array with equidistant vectors representing an X and Y location and the angle it is facing
function draw_tracks(_xPos, _yPos, _list, _trackSize = 64) {
	
	// Store each node/vector (X, Y, angle) into an array so that we can accurately draw trains on the track
	// while also maintaining clean and fast code
	var _vectors = [];

	var X = -_xPos;
	var Y = -_yPos;
	var curAngle = 0;
	var _totalDistance = 0
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
			if (Y > MAP_VIEW_Y + _trackWidth) and (X < camera_get_view_width(get_map_camera()) + _trackWidth) {
					
				// Draw the tracks
				draw_sprite_ext(_trackSprite, 0, X,Y, trackScale, 1, curAngle + 90, c_white, 1);
			}
			
			// Store the vector in the vectors array
			array_push(_vectors, [X, Y, curAngle]);
	
			prevX = X;
			prevY = Y;
		}
	}
	
	return _vectors;
}

// Draw the train on the track using the vectors array generated with the draw_tracks() function
function draw_train_cart(_vectors = [[0,0,0]], _trainDistance = 0, _cartSprite = spr_car_top_engine, _trackSize = 64) {
	
	// Find how many vectors there are (to prevent errors)
	var _vectorsLength = array_length(_vectors);
	
	// Find which vectors to get data from based on the train's location
	var _floorVectorLoc = max(floor(_trainDistance/_trackSize), 0); // Used to retrieve base X and Y location and angle
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
	var _trainX = _baseX + lengthdir_x(_distanceFromBaseVector, _trainAngle);
	var _trainY = _baseY + lengthdir_y(_distanceFromBaseVector, _trainAngle);
	
	draw_sprite_ext(_cartSprite, 0, _trainX, _trainY, 4, 4, _trainAngle, c_white, 1);
}

function draw_train(_vectors = [[0,0,0]], _carts = [CARTS.ENGINE], _frontTrainDistance = 0, _trackSize = 64) {
	
	var _trainScale = 4;
	
	// Create a mutable variable to calculate the distances of every cart
	var _cartDistance = _frontTrainDistance;
	
	// Loop for every cart
	for (var i = 0; i < array_length(_carts); i++) {
		
		// Get the cart sprite and width
		var _cartData = get_cart_data(_carts[i]);
		
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
		draw_train_cart(_vectors, _cartDistance, _cartTopSprite);
		
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
	}
}