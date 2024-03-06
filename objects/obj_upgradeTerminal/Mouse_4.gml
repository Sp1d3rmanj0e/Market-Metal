/// @description Insert description here
// You can write your code in this editor

showing_upgrade_gui = !showing_upgrade_gui;

if (showing_upgrade_gui) {
	
	gui_id = instance_create_layer(0, 0, "GUI", obj_guiScreen,
	{
		gui_screen_state: GUI.UPGRADE,
		argument_1 : inventory_id,
		argument_2 : obj_player.inventory_id,
		argument_3 : parent_id
	});
	
	with(obj_player) focus_camera(other.parent_id);
	
	//gui_draw_cart_upgrade(inventory_id, obj_player.inventory_id);
} else {
	if (instance_exists(gui_id))
		instance_destroy(gui_id);
	
	with(obj_player) unfocus_camera();
}