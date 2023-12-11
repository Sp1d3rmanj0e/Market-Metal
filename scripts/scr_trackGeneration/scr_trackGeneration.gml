
// Returns a ds_list containing between 50-150 tracks
// Each track is an array containing [length (3 - 7), angle (-90 - 90)]

/// @param _seed - the map seed
/// @param _xPos and _yPos - these aren't the world X and Y coordinates, these signify how far from the starting track is
/// @param _curAngle - Store the current track information | We do this to prevent tracks from moving backwards

/// @returns _tracksList - a Ds_list containing a list of track lengths and angles

function create_tracks(_seed, _xPos, _yPos, _curAngle){
	
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

// Given a start location, angle, and seed, generate a new set of tracks
// and return the end vector (X, Y, angle) as well as the generated vector in a map
function generate_track_data (_startX = 0, _startY = 0, _startAngle = 0, _seed = global.seed) {
	
	var _list = create_tracks(_seed, _startX, _startY, _startAngle); // Xpos and Y pos are switched to ensure different tracks are generated
	var _vectorMap = draw_tracks(0, 0, _list, _startX, _startY, _startAngle); // Generate a list of vector locations and get the end X, Y, and Angle
	
	ds_map_add(_vectorMap, "list", _list);
	
	// Keys: "vectors", "endX", "endY", "endAngle", "list"
	return _vectorMap;
}


// Given the starting vector of the track and the track map, generate and replace the current two
// track options with a new 2 track options

// This will typically be used when the player chooses a track to go onto and now a new 2future
// tracks need to be generated
function generate_next_track_options(_trackMap, _seed = global.seed) {
	
// Start by getting the endX, endY, and endAngle of the currentTrack
var _endX, _endY, _endAngle, _dataMap;

var _curTrackMap = ds_map_find_value(_trackMap, "CurrentTrack");
_endX		= ds_map_find_value(_curTrackMap, "endX");
_endY		= ds_map_find_value(_curTrackMap, "endY");
_endAngle	= ds_map_find_value(_curTrackMap, "endAngle");

// Generate the first track option
_dataMap = generate_track_data(_endX, _endY, _endAngle, _seed);
ds_map_replace(_trackMap, "FutureTrack1", _dataMap);

// Generate the second track option
_dataMap = generate_track_data(_endX, _endY, _endAngle, _seed*_endX/_endY);
ds_map_replace(_trackMap, "FutureTrack2", _dataMap);

}