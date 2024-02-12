/// @description Insert description here
// You can write your code in this editor

current_biome_map = noone;


alarm[0] = 1;
alarm[1] = 5; // Give time to load the first biome map in

// With help from https://dev.to/jacktt/understanding-the-weighted-random-algorithm-581p
function get_value_from_weights(_valueArr, _weightArr) {
	
	// Get the total weight
	var _totalWeight = 0;
	for (var i = 0; i < array_length(_weightArr); i++) {
		var _weight = _weightArr[i];
		_totalWeight += _weight;
	}

	// Choose a random number between 0 and total weight
	randomize();
	var _randomChoice = random(_totalWeight);

	// Find the value that corresponds with that chosen weight
	_totalWeight = 0;
	for (i = 0; i < array_length(_weightArr); i++) {
		_totalWeight += _weightArr[i];
		
		// If the random choice fits within the weight window,
		// return the corresponding value
		if (_randomChoice < _totalWeight) {
			return _valueArr[i];
		}
	}
}