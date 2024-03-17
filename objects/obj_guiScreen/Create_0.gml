/// @description Insert description here
// You can write your code in this editor

if (instance_number(obj_guiScreen) > 1)
	instance_destroy();

mouse_clear(mb_left);

// Variables given upon creation
// gui_screen_state - a GUI enum telling the GUI which GUI to display

slider_1_mouse = 0;
slider_1_val = 0;

view_set_visible(1, false);