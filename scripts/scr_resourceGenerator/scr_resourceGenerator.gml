
function get_resources_from_biome(_biomeMap) {
	return ds_map_find_value(_biomeMap, "resources");
}

function spawn_resources(_seed, _startX, _startY, _genWidth, _genHeight, _spacing = 100, _variability = 10, _cutoff = 10, _scale = BIOME_SCALE) {
	
	// To prevent data leaks, despawn any resources that have existed for a while
	with(par_willDespawn) {
		decrement_despawn_timer();
	}
	
	var _curLayerDepth = layer_get_depth(layer_get_id("Resources"));
	
	var _density;
	for (var _x = _startX; _x < (_startX + _genWidth); _x += _spacing) {
	for (var _y = _startY; _y < (_startY + _genHeight); _y += _spacing) {
		
		// Get resource details based on the biome
		var _biome = get_biome_at_tile(_seed, _x + map_cam_x, _y + map_cam_y, 256, BIOME_SCALE);
		var _resourceArr = get_resources_from_biome(_biome);
		
		var _array, _resource, _percentChance;
		var _resourceSprite;
		for (var i = 0; i < array_length(_resourceArr); i++) {
	
			// Unpack the array
			_array = _resourceArr[i]; // Get the specific resource from that biome
			_resource = _array[0];  // Get the resource enum
			_percentChance = _array[1]; // Get the percent chance that it spawns
		
			// Get the resource sprite from the resource enum
			_resourceSprite = get_resource_sprite_from_enum(_resource);
			
			// Get the resource density of that area on the map
			_density = round(noise_scale(_seed + i, _x + map_cam_x, _y + map_cam_y, _scale) * 100 - _cutoff);
			
			randomize();
			if (_density >= irandom(100)) {
				if (_percentChance >= random(100)) {
					
					// Calculate what the depth of the new resource should be
					var _howFarDown = (_y-_startY)/_genHeight; // A number between 0 and 1, with 1 being at the bottom of the gen zone
					
					// The further down you are, the lower the depth (higher on screen)
					var _newDepth = lerp(_curLayerDepth, _curLayerDepth-99, _howFarDown);
					//log(_newDepth);
					
					instance_create_layer(
						_x + random_range(-_variability, _variability), 
						_y + random_range(-_variability, _variability), 
						"resources", 
						obj_resourceTest,
						{
							resource_id : _resource, // Give the sprite its resource enum
							sprite_index : _resourceSprite, // Set the resource's sprite
							target_depth : _newDepth
						});
						
				}
			}
		}
	}}
}

// Destroys all resources that are within the radius of a given point
function remove_resources_near_point(_x, _y, _radius) {
	var _resourceList = ds_list_create();
	var _numFound = collision_circle_list(_x, _y, _radius, obj_resourceTest, false, false, _resourceList, false);
	
	if (_numFound != 0) {
		for (var j = 0; j < ds_list_size(_resourceList); j++) {
			var _resourceId = ds_list_find_value(_resourceList, j);
			instance_destroy(_resourceId);
		}
	}
		
	ds_list_destroy(_resourceList);
}

/// @param _vectors [[X, Y, Angle], ...]
function remove_resources_near_track(_vectors) {
	
	var _vector, _x, _y;
	for (var i = 0; i < array_length(_vectors); i++) {
		_vector = _vectors[i];
		
		_x = _vector[0];
		_y = _vector[1];
		
		remove_resources_near_point(_x, _y, 15);
		
	}
}

/// @param _vectors [[X, Y, Angle], ...]
function spawn_resources_along_track(_vectors) {
	
	var _highestY = 0;
	var _lowestY = 0;
	var _startX = _vectors[0][0];
	var _endX = _vectors[array_length(_vectors)-1][0];
	
	// Get min and max y elevations from the vectors
	var _x, _y, _array;
	for (var i = 1; i < array_length(_vectors); i++) {
		_array = _vectors[i];
		
		_x = _array[0];
		_y = _array[1];
		
		if (_y < _highestY)
			_highestY = _y;
			
		if (_y > _lowestY)
			_lowestY = _y;
	}
	
	var _height = _lowestY - _highestY;
	var _width = _endX - _startX;
	
	spawn_resources(global.seed, _startX, _highestY - 100, _width, _height + 200,  50, 0, 70, 5000);
	
	remove_resources_near_track(_vectors);
	
}
function spawn_along_track_tester(_vectors, _object) {
	
	var _arrayLen = array_length(_vectors);
	var _pointAlongArray = _vectors[irandom_range(0, _arrayLen-1)];
	
	var _x = _pointAlongArray[0];
	var _y = _pointAlongArray[1];
	var _angle = _pointAlongArray[2];
	
	instance_create_layer(_x, _y, "Resources", _object, 
	{
		image_angle : _angle,
		map_x : _x + obj_mapController.map_cam_x,
		map_y : _y + obj_mapController.map_cam_y
	});
}

function spawn_train_station(_vectors) {
	
	var _arrayLen = array_length(_vectors);
	var _endPoint = _vectors[_arrayLen-1];
	
	var _x = _endPoint[0];
	var _y = _endPoint[1];
	var _angle = _endPoint[2];
	
	instance_create_layer(_x, _y, "Resources", obj_trainStation, 
	{
		image_angle : _angle,
		map_x : _x + obj_mapController.map_cam_x,
		map_y : _y + obj_mapController.map_cam_y
	});
}