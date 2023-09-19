/// @description Animations

if (moveX != 0) sprite_index = spr_player_right;
else sprite_index = spr_player_idle;

if (moveX > 0) image_xscale = 1;
else image_xscale = -1;