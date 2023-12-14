
function get_resources_from_biome(_biomeMap) {
	return ds_map_find_value(_biomeMap, "resources");
}

function spawn_resources(_seed, _startX, _startY, _genWidth, _genHeight, _spacing = 100, _variability = 10, _cutoff = 10, _scale = BIOME_SCALE) {
	
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
			
			_density = round(noise_scale(_seed + i, _x + map_cam_x, _y + map_cam_y, 4000) * 100 - _cutoff);
		
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