#macro OCTAVES 5

// Returns a consistent random number between 0 and 1 based on the x and y location
function generateVector(_seed, _x, _y) {
	
	// Generate a seed based on the current seed and the point location
    var _new_seed = _seed + _x*65336 + _y;
	random_set_seed(_new_seed);
	
	// Return a value between 0 and 1 (based on seed)
    return random(1);
}

// Returns a procedurally generated number based on the seed and x/y coordinates
// It utilizes perlin noise and vectors to lerp between 4 different random numbers 
// based on how close you are to any given vector
function noise(_seed, _x, _y) {
    
	// Get bottom left coordinate of the current grid a point is in
    var _gridX = floor(_x);
    var _gridY = floor(_y);
    
	// Gets how far in a point is within a vector
    var _xOff = _x - floor(_x);
    var _yOff = _y - floor(_y);
    
    // generate all of the grid vectors
	var _tl, _tr, _bl, _br;
    _tl = generateVector(_seed, _gridX, _gridY+1);
    _tr = generateVector(_seed, _gridX+1, _gridY+1);
    _bl = generateVector(_seed, _gridX, _gridY);
    _br = generateVector(_seed, _gridX+1, _gridY);
    
	
	// Lerp between all vectors
    var _topX = lerp(_tl, _tr, _xOff);
    var _bottomX = lerp(_bl, _br, _xOff);
    var _point = lerp(_bottomX, _topX, _yOff);
	
	// Return the value at (x, y)
    return _point;
}

function noise_octave(_seed, _x, _y, _octaves = OCTAVES) {
	
	// Gets the original value with no octaves
	var _point = noise(_seed, _x, _y);
	
	// For every octave, generate a new noise map and add it to the original with decreasing influence
	for (var _octave = 1; _octave < _octaves; _octave++) {
		
		var _newNoise = noise(_seed + _octave *100.123, _x/_octave, _y/_octave) - 0.5; // gets a scale between -0.5 and 0.5
		_newNoise *= (1/_octave); // This decreases the influence of a noise every octave
		_point += _newNoise;
	}
	
	return _point;
}