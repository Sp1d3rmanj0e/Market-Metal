/// @description Fading mechanics

// Change outside cover alpha based on whether or not the player is inside it
if (obj_player.bbox_right > bbox_left - fade_dist_buffer) and (obj_player.bbox_left < bbox_right + fade_dist_buffer) {
	image_alpha = max(0, image_alpha-0.05);
} else {
	image_alpha = min(1, image_alpha+0.05);
}