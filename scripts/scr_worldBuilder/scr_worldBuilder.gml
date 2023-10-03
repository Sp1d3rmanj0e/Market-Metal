

function reload_world() {
	
}
/// @desc using the data given, uses perlin noise maps to associate each space with a biome tile.
/// @param _seed     - the seed of the map used
/// @param _tilemapX - the leftmost border of the biome reload zone
/// @param _tilemapY - the topmost border of the biome reload zone
/// @param _tilemapW - the width of the biome reload zone
/// @param _tilemapH - the height of the biome reload zone
/// @param _trainX   - the x offset location of the starting train view relative to the center of the noise map
/// @param _trainY   - the y offset location of the starting train view relative to the center of the noise map
/// @param _tileSize - the size of the tileset used
/// @param _tilemap  - the id of the tilemap to execute this function on
/// @param _scale    - the zoom of the noise map.  The larger the zoom, the larger the biomes
function reload_biomes(_seed, _tilemapX, _tilemapY, _tilemapW, _tilemapH, _trainX, _trainY, _tileSize, _tilemap, _scale = BIOME_SCALE) {
	
	// Loop through each tile location in the specified range
	for (var _x = _tilemapX; _x < _tilemapX + _tilemapW; _x+= _tileSize) {
	for (var _y = _tilemapY; _y < _tilemapY + _tilemapH; _y+= _tileSize) {	
		
		// Get relative location for given point
		// (To do this, we add _trainX/Y to our current point to offset it)
		// This means that for every 1 tile moved, one of the point variables will change by 1 as well
		var _pointX = _x/_tileSize + _trainX;
		var _pointY = _y/_tileSize + _trainY;
		
		// Get the biome from that point
		var _biome = get_biome_at(_seed, _pointX, _pointY, _scale);
		
		// Get the tilemap number from the biome
		var _tileNum = ds_map_find_value(_biome, "tNum");
		
		// Set the tile
		tilemap_set_at_pixel(_tilemap,_tileNum, _tilemapX, _tilemapY);
		
	}}
}