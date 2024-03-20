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
function inventory_was_updated() {
	log("Upgrading cart!");
	
	// Update previous contents so that we can check in the future
	// if the inventory was changed again or not
	update_prev_contents();
	
	// Check to see if the new inventory is valid.
	// If it is, update the cart's values.  Otherwise,
	if (confirm_upgrades_are_valid())
		update_cart();
	else
		log("not all items in the inventory are valid!");
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
	
	for (var i = 0; i < array_length(previous_contents); i++) {
		
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

function update_cart() {
	
	log("previous contents: " + string(previous_contents));

	for (var i = 0; i < array_length(previous_contents); i++) {
		
		// Get the item enum from the list of upgrades
		var _upgradeEnum = previous_contents[i];
		
		log("upgrade enum to upgrade cart with: " + string(_upgradeEnum));
		
		with(parent_id) {upgrade_cart(_upgradeEnum);}
	}
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
		
		log("got inventory item: " + string(_invItem));
		log("health item is: " + string(ITEM.UPG_HEALTH));
		log("capacity item is: " + string(ITEM.UPG_CAPACITY));
		
		if (_invItem[$ "id"] != ITEM.NONE)
			array_push(_newContents, _invItem);
	}
	
	// Update previous contents with the new contents array
	previous_contents = _newContents;
}