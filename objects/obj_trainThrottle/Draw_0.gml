/// @description Insert description here
// You can write your code in this editor

//312

draw_sprite_stretched(spr_trainGUIHandle, 0, bbox_left+15, 312, sprite_get_width(spr_trainGUIHandle), y-312)

draw_set_color(c_ltgray);
//draw_rectangle(bbox_left + 10, 312, bbox_left+20, y, false);
//draw_rectangle(bbox_right - 10, 312, bbox_right-20, y, false);
draw_set_color(-1);

draw_self();