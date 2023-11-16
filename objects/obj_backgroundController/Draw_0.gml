/// @description Insert description here
// You can write your code in this editor

draw_sprite_ext(spr_backgrounds, 0, x, y, 1, 1, 0, c_white, crossfade_old);
draw_sprite_ext(spr_backgrounds, 0, x, y, 1, 1, 0, c_white, crossfade_new);

// Every background has a transfer time of 1 hour
// At 30 minutes, both backgrounds will be at 50% alpha

/**
 * The times are as follows:
 * 3 - 7 Sunrise
 * 7 - 18 Day
 * 19 - 23 Sunset
 * 23 - 3 Night/Aurora Borealis
 */
 
 