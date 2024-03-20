/// @description Insert description here
// You can write your code in this editor

// Variables given upon creation
// parent_id - the id of the cart that owns this terminal

num_upgrade_slots = 4;

inventory_id = create_inventory(num_upgrade_slots);

showing_upgrade_gui = false;

gui_id = noone;

prev_upgrade_inv = array_create(num_upgrade_slots, ITEM.NONE);

/// @desc compares the prev_upgrade_inv with the current upgrade inventory
///		  If the values are different, the inventory has changed
/// @returns true if inventory has changed, false if not
function upg_inventory_has_changed() {
	
	// Loop through every slot in the inventory
		// If there is an item, it will give the item
		// If there is no item, it will give ITEM.NONE
			// NOTE: Getting an empty cell from the inventory will return 0, not ITEM.NONE
	
	for (var i = 0; i < num_upgrade_slots; i++) {
		
		// Get the current inventory value
		var _curInvSlotPacket = inventory_get_item(inventory_id, i);
		
		// Overwrite 0 with ITEM.NONE if that exists
		var _curItemId;
		if (_curInvSlotPacket == 0) _curItemId = ITEM.NONE;
		else _curItemId = _curInvSlotPacket[$ "id"];
		
		var _prevInvSlotVal = prev_upgrade_inv[i];
		
		// Compare the two.  If the values are different, return true.
		// Otherwise, continue
		if (_curItemId != _prevInvSlotVal) {
			update_prev_upgrade_inv(); // Copy the new inventory over the old inventory
									   // so that this isn't called every single frame
			log("INVENTORY HAS CHANGED!");
			return true;
		}
	}
	
	// No differences found, return false
	return false;
}

// This function copies over all inventory contents into a 4-slot array.  We store this here
// to check if the inventory has changed since the last frame
// Empty slots are filled with ITEM.NONE
// Non-empty slots are filled with the corresponding item enum
function update_prev_upgrade_inv() {
	
	log("UPDATING PREV UPGRDE INV");
	
	// Update previous_contents with the new inventory contents 
	// (Using item_enum as the value to keep things simple)
	for (var i = 0; i < num_upgrade_slots; i++) {
		
		// Get the item packet from that inventory slot
		var _itemPacket = inventory_get_item(inventory_id, i);
		
		// Overwrite 0 with ITEM.NONE if that exists
		var _itemId;
		if (_itemPacket == 0) _itemId = ITEM.NONE;
		else _itemId = _itemPacket[$ "id"];
		
		prev_upgrade_inv[i] = _itemId;
		log("Updated slot: " + string(i) + " with item id: " + string(_itemId));
	}
}


// This is called whenever the inventory has an update
function upg_inventory_was_updated() {
	update_cart();
}

/// @desc - looks at all currently equipped upgrades as well as the cart's compatabilities
///			and checks to make sure that all the items in the upgrade slots are valid.
///			What that means is that there will only ever be one type of upgrade per cart (no double health upgrades)
///			and all items in the upgrade slot must be compatible upgrades ("you can't add capacity to things like the farm cart)
/// @returns true - if all the upgrades are valid.  False if not.
function confirm_upgrades_are_valid() {
	
	// Get our cart's compatabilities
	// Ex. ["health", ...]
	var _compatabilityArr = get_cart_upgrade_compatabilities(parent_id.object_index);
	
	// Keeps track of all the passed upgrades.  If at any point, one of the classes is 
	// added twice, we have a duplicate, which is not allowed
	var _currentUpgradeDict = ds_map_create();
	
	for (var i = 0; i < num_upgrade_slots; i++) {
		
		// Get an item from the upgrade contents
		var _upgradeEnum = previous_contents[i];
		
		// Get which class the upgrade comes from (Ex. "health", "capacity", etc.)
		var _upgradeClass = get_upgrade_enum_class(_upgradeEnum);
		
		// Checks to see if the upgrade class is a valid upgrade for the current train
		// Return false immediately if one of the upgrades is not compatible
		if (!class_is_valid(_compatabilityArr, _upgradeClass)) {
			ds_map_destroy(_currentUpgradeDict);
			return false;
		} else {
			
			// Add the item to a temporary dictionary to keep track of all upgrades that
			// have passed the check.  We do this to see if the player attempted to put
			// a second upgrade of the same type in the upgrade slot (which isn't allowed)
			if(ds_map_find_value(_currentUpgradeDict, _upgradeClass) != undefined) {
				
				// There's already an upgrade like this in this inventory, which is not good
				ds_map_destroy(_currentUpgradeDict);
				return false;
			} else {
				// First instance of this type of upgrade
				// Add it to the array so that if another item with the same
				// class appears, we will know it is a duplicate
				ds_map_add(_currentUpgradeDict, _upgradeClass, 0);
			}
		}
		
		// Nothing has caused the function to return false, so return true;
		ds_map_destroy(_currentUpgradeDict);
		return true;
	}
}

// Cross checks an upgrade class along a compatability array
/* Ex.
	_upgradeClass - "health"
	_compatabilityArr - ["capacity", "health"]
	
	Because health is in the compatability array, it will return true
*/
/// @returns - true if _upgradeClass is within _compatabilityArr, false if not
function class_is_valid(_compatabilityArr, _upgradeClass) {
	for (var i = 0; i < array_length(_compatabilityArr); i++) {
		var _validClass = _compatabilityArr[i];
		
		if (_upgradeClass == _validClass)
			return true;
	}
	
	return false;
}

// Searches through the equipped upgrades and gives back a dictionary containing the new stats
// of the train
function generate_upgrade_packet() {
	// Create a base level of cart upgrades to change based on the upgrades equipped
	var _upgradePacket = generate_base_upgrade_packet();
	
	// Loop through all equipped upgrades and alter the upgrade packet accordingly
	for (var i = 0; i < num_upgrade_slots; i++) {
		
		// Get an item from the array
		var _itemEnum = prev_upgrade_inv[i];
		
		// If the item is not empty, add its value to the upgrade packet
		if (_itemEnum != ITEM.NONE) {
			
			// Get the key and benefit from the item
			// Ex. Class: "health" Benefit: 125
			var _itemClass = get_upgrade_class(_itemEnum);
			var _itemValue = get_upgrade_benefit(_itemEnum);
			
			// Alter the upgrade packet
			_upgradePacket[$ _itemClass] = _itemValue;
		}
	}
	
	// Return the modified upgrade packet
	return _upgradePacket;
}

// Get the new upgrade packet generated based on the upgrade items in the inventory
// Then send that packet to the cart to upgrade itself
function update_cart() {
	
	// Get the updated upgrade packet
	var _upgradePacket = generate_upgrade_packet();
	
	// Tell the cart we are in control of to change its values based on this new upgrade packet
	with(parent_id) {upgrade_cart(_upgradePacket)};
}

