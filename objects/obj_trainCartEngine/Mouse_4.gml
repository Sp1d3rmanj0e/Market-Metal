/// @description Insert description here
// You can write your code in this editor

crafting_research_gui_open = !crafting_research_gui_open;

if (!instance_exists(crafting_research_id)) {
	crafting_research_id = instance_create_layer(0, 0, "GUI", obj_guiScreen,
		{
			gui_screen_state : GUI.CRAFTING,
			argument_1 : obj_player.inventory_id
		});
}