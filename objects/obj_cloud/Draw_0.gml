/// @description Insert description here
// You can write your code in this editor

var _prevSprite = get_sprite_based_on_time(obj_backgroundController.previous_background);
var _curSprite = get_sprite_based_on_time(obj_backgroundController.current_background);

draw_sprite_ext(sprite_index, _prevSprite, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha * (1-obj_backgroundController.crossfade));
draw_sprite_ext(sprite_index, _curSprite, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha * obj_backgroundController.crossfade);