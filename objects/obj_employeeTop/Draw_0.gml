/// @description Insert description here
// You can write your code in this editor

// Switch sprite based on indoors/outdoors
if (is_outdoors) {
	sprite_index = spr_player_top;
} else {
	if (!is_sitting) {
		sprite_index = spr_passengerCurvyWalk;
	} else {
		sprite_index = spr_passengerCurvySit;
	}
}



if ((y > MAP_VIEW_Y) and (is_outdoors)) or ((y < MAP_VIEW_Y) and (!is_outdoors))
	draw_self();

draw_set_color(c_aqua);
draw_line_width(x, y, mouse_x, mouse_y, 5);


draw_text(x, y+40, "is_outside: " + string(is_outdoors));
draw_text(x, y+60, "profession: " + string(profession));
draw_text(x, y-40, "(" + string(x) + "), (" + string(y) + ")");


draw_text(x, y+80, string(ds_list_size(inventory)));

draw_set_color(-1);