/// @description Animations & Camera



// Camera follow player
/*
var _trainCam = obj_cameraManager.train_cam; // Get the train camera
camera_set_view_pos(
_trainCam, 
obj_player.x - camera_get_view_width(_trainCam)/2,
camera_get_view_y(_trainCam)
);
*/

// Flip based on direction
if (moveX != 0) sprite_index = spr_player_right;
else sprite_index = spr_player_idle;

if (moveX > 0) image_xscale = 1;
else image_xscale = -1;