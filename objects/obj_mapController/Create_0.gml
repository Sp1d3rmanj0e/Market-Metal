// Cam movement
map_cam_x = 0;
map_cam_y = 0;
map_cam_move_speed = 43;

list = create_tracks(global.seed, 0, 0, 50);
vector = draw_tracks(0, 0, list, 0, 0);

//var _endListVector = get_end_list_vector(list); // Returns the [X, Y, Angle] data from the last point in a given list
var _endListVector = vector[1]
var _endListX = _endListVector[0];
var _endListY = _endListVector[1];
var _endListAngle = _endListVector[2];

future_trackList1 = create_tracks(global.seed,_endListX, _endListY, _endListAngle);

trainPos = 0;