/// @description Insert description here
// You can write your code in this editor


image_alpha = alpha_fade;

draw_sprite_ext(spr_trainGUIHandle, 0, x, CONTROL_BOTTOM_Y - 5, 1, 1, 0, c_white, image_alpha);

draw_set_color(c_dkgray);

draw_rectangle(x-3, mid_y + (y-mid_y)/4, x+2, y, false);
draw_set_color(-1);

draw_self();

draw_text(x, y-15, get_throttle_amount());