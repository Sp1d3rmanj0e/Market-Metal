/// @description Insert description here
// You can write your code in this editor

current_biome_sprite = get_decor_sprite_from_biome(current_biome_name);

draw_sprite_ext(previous_biome_sprite, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, 1-fade);
draw_sprite_ext(current_biome_sprite, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, fade);