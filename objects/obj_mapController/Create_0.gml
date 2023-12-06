// Cam movement
map_cam_x = 0;
map_cam_y = 0;
map_cam_move_speed = 43;

track_order = ds_map_create();
ds_map_add(track_order, "PreviousTrack",	noone);
ds_map_add(track_order, "IgnoredTrack",		noone);
ds_map_add(track_order, "CurrentTrack",		noone);
ds_map_add(track_order, "PotentialTrack1",	noone);
ds_map_add(track_order, "PotentialTrack2",	noone);

var _dataMap;

// Get data for the starting track
_dataMap = generate_track_data(0, 0, 0, global.seed);
ds_map_replace(track_order, "CurrentTrack", _dataMap);

// Generate the first 2 future tracks
generate_next_track_options(track_order);

trainPos = 0;
