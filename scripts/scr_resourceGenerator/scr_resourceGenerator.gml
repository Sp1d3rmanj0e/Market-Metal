
function get_resources_from_biome(_biomeMap) {
	return ds_map_find_value(_biomeMap, "resources");
}

function spawn_resources(_seed, _startX, _startY, _genWidth, _genHeight, _spacing = 100, _variability = 10, _cutoff = 10, _scale = BIOME_SCALE) {
	
	// To prevent data leaks, despawn any resources that have existed for a while
	with(obj_resourceTest) {
		decrement_despawn_timer();
	}
	
	var _density;
	for (var _x = _startX; _x < (_startX + _genWidth); _x += _spacing) {
	for (var _y = _startY; _y < (_startY + _genHeight); _y += _spacing) {
		
		// Get resource details based on the biome
		var _biome = get_biome_at(_seed, _x + map_cam_x, _y + map_cam_y, BIOME_SCALE);
		var _resourceArr = get_resources_from_biome(_biome);
		
		var _array, _resource, _percentChance;
		var _resourceSprite;
		for (var i = 0; i < array_length(_resourceArr); i++) {
	
			// Unpack the array
			_array = _resourceArr[i];
			_resource = _array[0];
			_percentChance = _array[1];
	
			_resourceSprite = get_resource_sprite_from_enum(_resource);
			
			_density = round(noise_scale(_seed + i, _x + map_cam_x, _y + map_cam_y, _scale) * 100 - _cutoff);
		
			randomize();
			if (_density >= irandom(100)) {
				if (_percentChance >= irandom(100)) {
					instance_create_layer(
						_x + random_range(-_variability, _variability), 
						_y + random_range(-_variability, _variability), 
						"resources", 
						obj_resourceTest,
						{
							sprite_index : _resourceSprite
						});
				}
			}
		}
	}}
}

/// @param _vectors [[X, Y, Angle], ...]
function spawn_resources_along_track(_vectors) {
	
	var _highestY = 0;
	var _lowestY = 0;
	var _startX = _vectors[0][0];
	var _endX = _vectors[array_length(_vectors)-1][0];
	
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
	
}