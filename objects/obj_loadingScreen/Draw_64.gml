/// @description Insert description here
// You can write your code in this editor

var _camW = camera_get_view_width(global.currentCamera);
var _camH = camera_get_view_height(global.currentCamera)

draw_sprite_stretched(sprite_index, 0, 0, 0, _camW, _camH);

draw_set_halign(fa_center);
draw_set_valign(fa_center);

draw_set_font(fnt_title);

draw_text(_camW/2, _camH/2, "Loading Map");

draw_set_font(fnt_default);

draw_set_halign(fa_left);
draw_set_valign(fa_top);