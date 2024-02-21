/// @description Insert description here
// You can write your code in this editor





if (y > MAP_VIEW_Y) {

	draw_self();

	draw_set_halign(fa_center);

	draw_text(x, y+30, name);
	draw_text(x, y+50, string(item_enum));

	draw_set_halign(fa_left);
}