/// @description Insert description here
// You can write your code in this editor

event_inherited(); // Move along map

if (point_distance(x, y, global.train_x, global.train_y) < 500) {
	draw_sprite(spr_tooltipRemount, 0, x - 25, y);
}