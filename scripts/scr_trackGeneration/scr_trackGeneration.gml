
// Returns a ds_list containing between 50-150 tracks
// Each track is an array containing [length (3 - 7), angle (-90 - 90)]

/// @param _seed - the map seed
/// @param _xPos and _yPos - these aren't the world X and Y coordinates, these signify how far from the starting track is

function create_tracks(_seed, _xPos, _yPos){
	
	// Create a list to store the track data
	var _tracksList = ds_list_create();
	
	// Set the seed based on the location
	random_set_seed(_seed + _xPos/14.125677*_yPos);
	
	// Get how many tracks to generate
	var _numTracksGenerated = irandom_range(50, 150);
	
	// Create a list of all upcoming tracks
	for (var loop = 0; loop < _numTracksGenerated; loop++) {

		// Create a vessel to store a single track's information
		// [Length, Angle]
		var _trackData = array_create(2);
	
		// Choose a random length for the track
		_trackData[0] = choose(3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 7);
	
		// 50% chance to be a straight line of track
		if (irandom(100) > 50) {

			_trackData[1] = 0;
		
		// 50% chance to be an angled piece of track
		} else {
	
			_trackData[1] = choose(25, 30, 30, 45, 90) * choose(1, -1);
	
		}

		// Prevent sharp 90 degree turns with this manual filter
		if (_trackData[0] == 3) && (_trackData[1] == 90) _trackData[0] = 4;
		
		// Add the track to the list of tracks
		ds_list_add(_tracksList, _trackData);
	}
	
	return _tracksList;
}