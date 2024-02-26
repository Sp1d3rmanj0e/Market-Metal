/// @description Insert description here
// You can write your code in this editor


if (throttle_grabbed) {
	cur_y = mouse_y;
	cur_y = clamp(cur_y, max_y, min_y);
}

if point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom) {
	image_index = 1;
} else {
	image_index = 0;
}

y = cur_y;