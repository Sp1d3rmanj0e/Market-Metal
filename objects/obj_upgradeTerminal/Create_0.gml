/// @description Insert description here
// You can write your code in this editor

// Variables given upon creation
// parent_id - the id of the cart that owns this terminal

inventory_id = create_inventory(4);

showing_upgrade_gui = false;

gui_id = noone;

previous_contents = [];

// Updates previous contents and the cart properties based on 
// the new contents in the upgrade inventory
function update() {
	log("Upgrading cart!");
	
	update_prev_contents();
	update_cart();
}

function update_cart() {
	var _upgradePacket = generate_default_upgrade_packet();
	
	for (var i = 0; i < array_length(previous_contents); i++) {
		var _upgradeItem = previous_contents[i];
		
		update_upgrade_packet(_upgradePacket, _upgradeItem);
	}
	
	// Tell the cart that their upgrades have changed
	with(parent_id) {update_upgrades(_upgradePacket);
		log("UPDAGITING UPGRADES X4");}
}

// This function looks at the current upgrade inventory and adds all non-ITEM.NONE items
// into the previous_contents array
function update_prev_contents() {
	
	var _newContents = [];
	var _numInvSlots = ds_grid_height(inventory_id);
	
	// Update previous_contents with the new inventory contents 
	// (Using item_enum as the value to keep things simple)
	for (var i = 0; i < _numInvSlots; i++) {
		
		// Get the item id from that inventory slot
		var _invItem = inventory_get_item(inventory_id, i)[$ "id"];
		
		if (_invItem[$ "id"] != ITEM.NONE)
			array_push(_newContents, _invItem);
	}
	
	// Update previous contents with the new contents array
	previous_contents = _newContents;
}