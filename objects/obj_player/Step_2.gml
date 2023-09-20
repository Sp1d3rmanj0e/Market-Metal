/// @description Animations & Camera



// Camera follow player

var _train_cam = obj_cameraManager.train_cam; // Get the train camera
camera_set_view_pos(
_train_cam, 
obj_player.x - camera_get_view_width(_train_cam)/2,
obj_player.y - camera_get_view_height(_train_cam)/1.5
);

// Flip based on direction
if (moveX != 0) sprite_index = spr_player_right;
else sprite_index = spr_player_idle;

if (moveX > 0) image_xscale = 1;
else image_xscale = -1;