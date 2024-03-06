/// @description Insert description here
// You can write your code in this editor

// Undo GUI effect if applicable
if (obj_player.focus_camera)
	with(obj_player) unfocus_camera();

instance_destroy();

