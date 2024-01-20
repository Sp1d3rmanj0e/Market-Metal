/// @description Dismount the train

if (!instance_exists(obj_playerTop)) {
	player_id = instance_create_layer(global.train_x - map_cam_x, global.train_y - map_cam_y, "Resources", obj_playerTop);
	global.playerDismounted = true;
} else {
	global.playerDismounted = false;
	instance_destroy(player_id)
}
	
