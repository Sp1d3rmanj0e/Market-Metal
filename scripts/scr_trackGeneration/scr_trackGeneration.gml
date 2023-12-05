
// Returns a ds_list containing between 50-150 tracks
// Each track is an array containing [length (3 - 7), angle (-90 - 90)]

/// @param _seed - the map seed
/// @param _xPos and _yPos - these aren't the world X and Y coordinates, these signify how far from the starting track is
/// @param _curAngle - Store the current track information | We do this to prevent tracks from moving backwards

function create_tracks(_seed, _xPos, _yPos, _curAngle = 0){
	
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
		} else { // 50% chance to be an angled piece of track
			_trackData[1] = irandom_range(25, 90) * choose(1, -1);
		}

		// Prevent sharp 90 degree turns with this manual filter
		if (_trackData[0] == 3) && (_trackData[1] == 90) _trackData[0] = 4;
		
		// Calculate the new angle after this track were to finish
		// If the angle would end up going backwards, flip it so that it faces the other direction
		if (_curAngle +  _trackData[1] > 90) or (_curAngle + _trackData[1] < -90) {
			_trackData[1] = _trackData[1] * -1;
		}
		
		// Update the new angle
		_curAngle += _trackData[1];
		
		// Add the track to the list of tracks
		ds_list_add(_tracksList, _trackData);
	}
	
	return _tracksList;
}

// Returns the [X, Y, Angle] data from the last point in a given list
function get_end_list_vector(_list, _startAngle = 0, _trackSize = TRACK_SIZE) {
	
	var Len;
	var X = 0;
	var Y = 0;
	var Angle = _startAngle;
	var _dsList;
	
	var _listLen = ds_list_size(_list);
	for (var i = 0; i < _listLen; i++) {
		_dsList = ds_list_find_value(_list, i);
		
		Len = _dsList[0] * (_trackSize);
		Angle += _dsList[1];
		
		X += lengthdir_x(Len, Angle);
		Y += lengthdir_y(Len, Angle);
	}
	
	return [X,Y,Angle];
}