draw_biomes(
	global.seed, 
	camera_get_view_y(get_map_camera()), 
	camera_get_view_width(get_map_camera()), 
	camera_get_view_height(get_map_camera()), 
	map_cam_x, map_cam_y);

// Initialize variables
var _startX, _startY, _startAngle; // Start locations for PreviousTrack
var _trackMap, _list, _vectors, _endX, _endY, _endAngle;
var _trainMap; // Contains the real-time vectors that the train will use to draw its location
#region Draw the previous track

/**
 * What we're doing here is drawing the track that we just travelled on
 * There is one edge case we have to check for and that's if we are on the first track of the game
 * in which there was no track to have previously travelled on
 * Hence, we do the !is_undefined() check.  It will only be undefined if there is no existing track there
 */

// Draw the previous track
_trackMap = ds_map_find_value(track_order, "PreviousTrack");
_startX = ds_map_find_value(_trackMap, "startX");
_startY = ds_map_find_value(_trackMap, "startY");
_startAngle = ds_map_find_value(_trackMap, "startAngle");
_list = ds_map_find_value(_trackMap, "list");

// Only draw the track if track data exists for it to process
if (!is_undefined(_list))
	draw_tracks(map_cam_x, map_cam_y, _list, _startX, _startY, _startAngle, false);

//draw_text_transformed(_startX - map_cam_x, _startY - map_cam_y, "Prev Track Start: (" + string(_startX) + ", " + string(_startY) + ")",10, 10, 0);

#endregion Draw the previous track

#region Draw the current and ignored track

/**
 * What we're doing here is drawing the track that the train will actively be on
 *
 * In order to do this, we must first find the starting point of the current track
 * We find this by finding the end point of the previous track to ensure a connected 
 * transition between the two
 *
 * We then draw the tracks, simultaneously storing the data generated from drawing the tracks
 * the "vectors" data point within the returned map contains the real-time X,Y,Angle points of all
 * points on the track.
 *
 * Using the vectors data, we then draw the train and the CurrentTrack section is complete
 */
 

// Get the end of the previous track (default is 0,0,0)
_trackMap = ds_map_find_value(track_order, "PreviousTrack");
_endX = ds_map_find_value(_trackMap, "endX");
_endY = ds_map_find_value(_trackMap, "endY");
_endAngle = ds_map_find_value(_trackMap, "endAngle");

//_endAngle = ds_map_find_value(_trackMap, "endAngle");

// Get the current track list
_trackMap = ds_map_find_value(track_order, "CurrentTrack");
_list = ds_map_find_value(_trackMap, "list");

// Draw the current track
_trainMap = draw_tracks(map_cam_x, map_cam_y, _list, _endX, _endY, _endAngle, true);

// The train is drawn at the end in order to draw over all of the tracks	
_vectors = ds_map_find_value(_trainMap, "vectors"); 	

if (!already_generated_resources) {
	spawn_resources_along_track(_vectors);
	spawn_along_track_tester(_vectors, obj_encampment);
	spawn_train_station(_vectors)
	already_generated_resources = true;
}

ds_map_destroy(_trainMap); // Destroy the unused map after vectors has been grabbed

//draw_text_transformed(_endX - map_cam_x, _endY - map_cam_y, "Current Track and Ignored Start: (" + string(_endX) + ", " + string(_endY) + ")",10, 10, 0);

// Get ignored track locations
_trackMap = ds_map_find_value(track_order, "IgnoredTrack")
_list = ds_map_find_value(_trackMap, "list");

// Draw the ignored track
if (!is_undefined(_list))
	draw_tracks(map_cam_x, map_cam_y, _list, _endX, _endY, _endAngle, false);

#endregion Draw the current and ignored track

#region Draw the Future Tracks

// Draw the future tracks

// Get the end location of the CurrentTrack
// It will be the starting points of the new tracks
_trackMap = ds_map_find_value(track_order, "CurrentTrack");

// Get the end location of the previous track
_endX = ds_map_find_value(_trackMap, "endX");
_endY = ds_map_find_value(_trackMap, "endY");
_endAngle = ds_map_find_value(_trackMap, "endAngle");

// Get data for the first future track
_trackMap = ds_map_find_value(track_order, "FutureTrack1");
_list = ds_map_find_value(_trackMap, "list");


// Draw the first future track
draw_tracks(map_cam_x, map_cam_y, _list, _endX, _endY, _endAngle, false);

//draw_text_transformed(_endX - map_cam_x, _endY - map_cam_y, "Future 1 Start: (" + string(_endX) + ", " + string(_endY) + ")",10, 10, 0);

// Get data for the second future track
_trackMap = ds_map_find_value(track_order, "FutureTrack2");
_list = ds_map_find_value(_trackMap, "list");

// Draw the second future track
draw_tracks(map_cam_x, map_cam_y, _list, _endX, _endY, _endAngle, false);

//draw_text_transformed(_endX - map_cam_x, _endY - map_cam_y, "Future 2 Start: (" + string(_endX) + ", " + string(_endY) + ")",10, 10, 0);

#endregion Draw the Future Tracks

// Draws the train based on the track vectors
// Result = false: not at the end; Result = "close": near the end; Result = true: at the end;
var _trainResult = draw_train(_vectors, global.currentCarts, trainPos);

if (_trainResult == true and !train_reached_the_end) {
	train_reached_the_end = true;
} else if (_trainResult < 30) {
	slow_down_train = _trainResult;
}

// Reserve a frame to allow for the creation of a loading screen
if (train_reached_the_end) {
	
	// If the train reached the end, but there is no loading
	// screen, create a loading screen
	if (!instance_exists(obj_loadingScreen)) {
		loading_screen_id = instance_create_layer(0, 0, "GUI", obj_loadingScreen);
		
	// Generate tracks 1 frame after the loading screen is created
	} else if (!tracks_generated){
		generate_next_tracks(1);
		tracks_generated = true;
		
		// Allow time for the loading screen to draw itself
		// before it destroys itself
		with(obj_loadingScreen) alarm[0] = 5;
	}
}