draw_biomes(global.seed, camera_get_view_y(get_map_camera()), camera_get_view_width(get_map_camera()), camera_get_view_height(get_map_camera()), map_cam_x, map_cam_y);


// Initialize variables
var _startX, _startY; // Start locations for PreviousTrack
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
_list = ds_map_find_value(_trackMap, "list");

// Only draw the track if track data exists for it to process
if (!is_undefined(_list))
	draw_tracks(map_cam_x, map_cam_y, _list, _startY, _startX);

#endregion Draw the previous track

// Draw the ignored track


#region Draw the current track

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
//_endAngle = ds_map_find_value(_trackMap, "endAngle");

// Get the current track list
_trackMap = ds_map_find_value(track_order, "CurrentTrack");
_list = ds_map_find_value(_trackMap, "list");

// Draw the current track
_trainMap = draw_tracks(map_cam_x, map_cam_y, _list, _endX, _endY);
_vectors = ds_map_find_value(_trainMap, "vectors");

// Draws the train based on the track vectors
draw_train(_vectors, global.currentCarts, trainPos);

#endregion Draw the current track

#region Draw the Future Tracks

// Draw the future tracks

// Get the end location of the CurrentTrack
// It will be the starting points of the new tracks
_trackMap = ds_map_find_value(track_order, "CurrentTrack");

// Get the end location of the previous track
_endX = ds_map_find_value(_trackMap, "endX");
_endY = ds_map_find_value(_trackMap, "endY");

// Get data for the first future track
_trackMap = ds_map_find_value(track_order, "FutureTrack1");
_list = ds_map_find_value(_trackMap, "list");


// Draw the first future track
draw_tracks(map_cam_x, map_cam_y, _list, _endX, _endY);

// Get data for the second future track
_trackMap = ds_map_find_value(track_order, "FutureTrack2");
_list = ds_map_find_value(_trackMap, "list");

// Draw the second future track
draw_tracks(map_cam_x, map_cam_y, _list, _endX, _endY);

#endregion Draw the Future Tracks