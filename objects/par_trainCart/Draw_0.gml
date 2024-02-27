/// @description Insert description here
// You can write your code in this editor

draw_self();

var _healthPercent = cart_health/max_cart_health * 100;

draw_set_color(c_white);
draw_rectangle(x - sprite_get_width(sprite_index), bbox_top, x, bbox_bottom, true);

draw_set_color(c_red);
draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
draw_set_color(-1);

//draw_healthbar(bbox_left + sprite_width/2 - 50, bbox_bottom + 5, bbox_left + sprite_width/2 + 50, bbox_bottom + 15, _healthPercent, c_black, c_red, c_green, 0, true, true);