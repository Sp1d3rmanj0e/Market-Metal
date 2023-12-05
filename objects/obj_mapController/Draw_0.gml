draw_biomes(global.seed, camera_get_view_y(get_map_camera()), camera_get_view_width(get_map_camera()), camera_get_view_height(get_map_camera()), map_cam_x, map_cam_y);
var _thing = draw_tracks(map_cam_x, map_cam_y, list);
var _vectors = _thing[0];
var _endListVector = _thing[1];

var _endListVector = vector[1]; //get_end_list_vector(list); // Returns the [X, Y, Angle] data from the last point in a given list
var _endListX = _endListVector[0];
var _endListY = _endListVector[1];
var _endListAngle = _endListVector[2];

draw_tracks(map_cam_x, map_cam_y, future_trackList1, _endListX, _endListY);
//draw_train_cart(_vectors, trainPos);
//draw_train(_vectors, [CARTS.ENGINE, CARTS.COAL, CARTS.FARM], trainPos);
draw_train(_vectors, global.currentCarts, trainPos);