/// @description Insert description here
// You can write your code in this editor

/*
draw_self();

draw_gui_background(x, y, 200, 200);

switch(level) {
	case 1: // Draw a 4X4 grid in the center of the screen
		draw_inventory(level_1_inv_id, x, y, 200, 200, 50, 2, 2, false, 0);
	break;
	case 2: // Draw an 8X4 grid in the center of the screen
		draw_inventory(level_1_inv_id, x, y, 100, 200, 50, 2, 2, false, 0);
		draw_inventory(level_2_inv_id, x+100, y, 100, 200, 50, 2, 2, false, 0);
	break;
	case 3: // Draw an 8X8 grid in the center of the screen
		draw_inventory(level_1_inv_id, x, y, 100, 100, 50, 2, 2, false, 0);
		draw_inventory(level_2_inv_id, x+100, y, 100, 100, 50, 2, 2, false, 0);
		draw_inventory(level_3_inv_id, x, y+100, 200, 100, 50, 2, 4, false, 0);
	break;
}