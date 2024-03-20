/// @description Insert description here
// You can write your code in this editor


// Check to see if the inventory has been updated since last frame

// Only bother checking if the upgrade menu is open
if (instance_exists(gui_id)) {
	
	// Check to see if the contents are different since last frame
	
	// If the lengths are different, easy giveaway that something's changed
	var _numInvItems = 4-inventory_get_number_open_slots(inventory_id);
	var _prevNumInvItems = array_length(previous_contents);
	
	if (_numInvItems != _prevNumInvItems) {
		log("sizes were different! Inventory had: " + string(_numInvItems) 
			+ " items, while prevContents had: " + string(_prevNumInvItems));
		inventory_was_updated();
	} else {
	
		// There's still a chance the inventory got updated without changing
		// the number of items in the inventory - like if the player swaps 
		// two items with a single click
	
		// This will compare the inventory's values with previous_content's values
		// if any value is different, upgrade_cart() will be called
		for (var i = 0; i < array_length(previous_contents); i++) {
			var _invValue = inventory_get_item(inventory_id, i)[$ "id"];
			var _prevContValue = previous_contents[i];
		
			// If a value doesn't match, end the for loop and update the cart
			if (_invValue != _prevContValue) {
				inventory_was_updated();
				break;
			}
		}
	}
}