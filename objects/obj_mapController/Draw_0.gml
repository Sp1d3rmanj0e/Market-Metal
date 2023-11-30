draw_biomes(global.seed, camera_get_view_y(get_map_camera()), camera_get_view_width(get_map_camera()), camera_get_view_height(get_map_camera()), map_cam_x, map_cam_y);
var _vectors = draw_tracks(map_cam_x, map_cam_y, list);
//draw_train_cart(_vectors, trainPos);
draw_train(_vectors, [CARTS.ENGINE, CARTS.COAL, CARTS.FARM], trainPos);