/// @description Insert description here
// You can write your code in this editor


// Check to see if the inventory has been updated since last frame

// Only bother checking if the upgrade menu is open
if (instance_exists(gui_id)) {
	
	if (upg_inventory_has_changed())
		upg_inventory_was_updated();
}