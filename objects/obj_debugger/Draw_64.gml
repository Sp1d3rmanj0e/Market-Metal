/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_red);
draw_text(10, 10, "X: " + string(x) + " | Y: " + string(y));
draw_text(10, 30, "TopY: " + string(camera_get_view_y(get_map_camera())));
draw_set_color(-1);