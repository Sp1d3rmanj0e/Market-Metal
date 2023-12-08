// Cam movement
map_cam_x = 0;
map_cam_y = 0;
map_cam_move_speed = 43;

track_order = ds_map_create();
ds_map_add(track_order, "PreviousTrack",noone);
ds_map_add(track_order, "IgnoredTrack",	noone);
ds_map_add(track_order, "CurrentTrack",	noone);
ds_map_add(track_order, "FutureTrack1",	noone);
ds_map_add(track_order, "FutureTrack2",	noone);

var _dataMap;

// Add a default PreviousTrack 
// (We manually add everything we need because the first one is supposed to be empty)
_dataMap = ds_map_create();
ds_map_add(_dataMap, "endX", 0);
ds_map_add(_dataMap, "endY", 0);
ds_map_add(_dataMap, "endAngle", 0);
ds_map_add(_dataMap, "startX", 0);
ds_map_add(_dataMap, "startY", 0);
ds_map_add(_dataMap, "startAngle", 0);
ds_map_replace(track_order, "PreviousTrack", _dataMap);
ds_map_replace(track_order, "IgnoredTrack", _dataMap);

// Get data for the starting track
_dataMap = generate_track_data(0, 0, 0, global.seed);
ds_map_replace(track_order, "CurrentTrack", _dataMap);

// Generate the first 2 future tracks
generate_next_track_options(track_order);

trainPos = 0;

/**
 * Moves:
 * PreviousTrack		>>> Trash
 * IgnoredTrack			>>> Trash (?)
 * CurrentTrack			>>> PreviousTrack
 * Selected FutureTrack >>> CurrentTrack
 * Ignored FutureTrack	>>> IgnoredTrack
 * 2 Future Tracks		>>> Generated
 
 /// @param _whichTrackWasSelected - 1 or 2
 */
function generate_next_tracks(_whichTrackWasSelected) {
	
	// Update the PreviousTrack "startX" and "startY" variables to shift the track over accordingly
	
	// We will do this by finding the end location of said PreviousTrack, and setting CurrentTrack's start 
	// location to that
	
	var _dataMap = ds_map_find_value(track_order, "PreviousTrack");
	var _startX = ds_map_find_value(_dataMap, "endX");
	var _startY = ds_map_find_value(_dataMap, "endY");
	
	_dataMap = ds_map_find_value(track_order, "CurrentTrack");
	ds_map_add(_dataMap, "startX", _startX);
	ds_map_add(_dataMap, "startY", _startY);
	
	trainPos = 0;
	
	// PreviousTrack >>> Trash
	// CurrentTrack >>> PreviousTrack
	ds_map_replace(track_order, "PreviousTrack", ds_map_find_value(track_order, "CurrentTrack"));
	
	// IgnoredTrack >>> Trash
	// FutureTrack >>> CurrentTrack
	// FutureTrack >>> IgnoredTrack
	if (_whichTrackWasSelected == 1) {
		ds_map_replace(track_order, "CurrentTrack", ds_map_find_value(track_order, "FutureTrack1"));
		ds_map_replace(track_order, "IgnoredTrack", ds_map_find_value(track_order, "FutureTrack2"));
	} else {
		ds_map_replace(track_order, "CurrentTrack", ds_map_find_value(track_order, "FutureTrack2"));
		ds_map_replace(track_order, "IgnoredTrack", ds_map_find_value(track_order, "FutureTrack1"));	
	}
	
	var _trackMap = ds_map_find_value(track_order, "CurrentTrack");
	var _CTEX = ds_map_find_value(_trackMap, "endX");
	var _CTEY = ds_map_find_value(_trackMap, "endY");
	_trackMap = ds_map_find_value(track_order, "FutureTrack1");
	var _FT1EX = ds_map_find_value(_trackMap, "endX");
	var _FT1EY = ds_map_find_value(_trackMap, "endY");
	
	// 2 Future Tracks >>> Generated
	generate_next_track_options(track_order);
}