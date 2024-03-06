/// @description Insert description here
// You can write your code in this editor

// Undo GUI effect if applicable
if (obj_player.focusing_camera)
	with(obj_player) unfocus_camera();

instance_destroy();

