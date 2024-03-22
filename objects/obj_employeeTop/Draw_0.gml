/// @description Insert description here
// You can write your code in this editor

// Switch sprite based on indoors/outdoors
if (is_outdoors) {
	sprite_index = spr_player_top;
} else {
	if (!is_sitting) {
		sprite_index = get_walk_sprite();
	} else {
		sprite_index = get_sit_sprite();
	}
}



if ((y > MAP_VIEW_Y) and (is_outdoors)) or ((y < MAP_VIEW_Y) and (!is_outdoors))
	if (!global.activelyMovingCart) {
		image_blend = skin_tone_color;
		draw_self();
		image_blend = c_white;
		
	}

if (!is_outdoors) {
	draw_hat();
	draw_shirt();
	draw_shoes();
}

draw_set_color(c_aqua);
//draw_line_width(x, y, mouse_x, mouse_y, 5);

/*
draw_text(x, y+40, "is_outside: " + string(is_outdoors));
draw_text(x, y+60, "profession: " + string(profession));
draw_text(x, y-40, "(" + string(x) + "), (" + string(y) + ")");
draw_text(x, y+80, string(stat_speed) + ", " + string(stat_resilience) + ", " + string(stat_metabolism) + ", " + string(stat_efficiency));
*/

//draw_text(x, y+80, string(ds_list_size(inventory)));

draw_set_color(-1);