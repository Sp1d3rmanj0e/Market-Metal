/// @description Show Inventory

// Close all other inventories
with (obj_employeeTop) {
	show_inventory = false;
}
show_inventory = true;


/*
if (!instance_exists(profile_ui_id)) {
	profile_ui_id = instance_create_layer(0, 0, "GUI", obj_guiScreen,
		{
			gui_screen_state : GUI.PROFILE,
			argument_1 : id
		});
}