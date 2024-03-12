/// @description Insert description here
// You can write your code in this editor

switch(gui_screen_state) {
	case GUI.UPGRADE:
		gui_draw_cart_upgrade(argument_1, argument_2, argument_3);
	break;
	case GUI.INVENTORY:
		gui_draw_passenger_exchange(x, y);
	break;
	case GUI.CRAFTING:
		gui_draw_research_crafting(argument_1, argument_2);
	break;
	case GUI.PROFILE:
		gui_draw_person_profile(argument_1);
	break;
}

//gui_draw_passenger_exchange(x, y);

/*
draw_gui_background(x, y, width, height);

draw_gui_button(x + 10, y + 10, width - 20, 30, "Button 1");

slider_1_packet = draw_gui_slider(x + 50, y + 50, 0, 100, slider_1_val, slider_1_mouse);
slider_1_val = slider_1_packet[0];
slider_1_mouse = slider_1_packet[1];

draw_gui_sub_gui(x + 10, y + 60, 150, 50);

draw_gui_text_box(x+ 10, y + 120, 100, 50, "Text box");
*/