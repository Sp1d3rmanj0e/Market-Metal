/// @description Crossfade backgrounds

// Draw the upcoming background (with slowly increasing alpha)
draw_sprite_ext(spr_backgrounds, current_background, x, y, 0.238, 0.125, 0, c_white, crossfade);

// Draw the previous background (with slowly reducing alpha)
draw_sprite_ext(spr_backgrounds, previous_background, x, y, 0.238, 0.125, 0, c_white, 1 - crossfade);

// Every background has a transfer time of 1 hour
// At 30 minutes, both backgrounds will be at 50% alpha

/**
 * The times are as follows:
 * 3 - 7 Sunrise
 * 7 - 18 Day
 * 19 - 23 Sunset
 * 23 - 3 Night/Aurora Borealis
 */