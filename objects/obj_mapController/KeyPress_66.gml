/// @description Dismount the train

instance_create_layer(global.train_x - 10, global.train_y - 20, "Resources", obj_playerTop);

global.playerDismounted = true;