/// @description Insert description here
// You can write your code in this editor

var _text = "(" + string(mouse_x + obj_mapController.map_cam_x) + ", " + string(mouse_y + obj_mapController.map_cam_y) + ")";
var _text2 = get_biome_at_tile(global.seed, mouse_x + obj_mapController.map_cam_x, mouse_y + obj_mapController.map_cam_y, 256, BIOME_SCALE);

draw_text_transformed(x + 20, y + 20, _text, 10, 10, 0);
draw_text_transformed(x + 20, y + 160, _text2, 10, 10, 0);