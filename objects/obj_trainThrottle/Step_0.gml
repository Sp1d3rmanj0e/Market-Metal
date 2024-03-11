/// @description Insert description here
// You can write your code in this editor

if (throttle_grabbed and alpha_fade > 0) {
	cur_y = mouse_y;
	cur_y = clamp(cur_y, max_y, min_y);
}

if point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom) {
	image_index = 1;
} else {
	image_index = 0;
}

y = cur_y;

// Fade in/out the throttle based on the player's distance to the engine
if (place_meeting(obj_player.x, obj_player.y, obj_trainCartEngine)) {
	alpha_fade = min(alpha_fade + fade_speed, 1);
} else {
	alpha_fade = max(alpha_fade - fade_speed, 0);
}