
#region upgrade explanation
/* Upgrade Pathway

(Starts in obj_upgradeTerminal)
1) Item gets put in or removed from upgrade inventory

2) call update(), which calls update_cart()
	a) Creates a default upgrade dictionary
	
	b) Loops through every equipped upgrade in the inventory
	
	c) Call update_upgrade_packet()
		i) Translates the item enum to a string that can act as a key (upgrade_enum_to_string())
		
		ii) Using the item enum, it finds the resulting stat bonus with get_upgrade_benefit()
		
		iii) Using the key found in step i, update the corresponding trait based on the stat bonus found
		
		iv) Return the updated upgrade packet
		
	d) Call the update_upgrades() function in par_trainCart, targeting the modified train.  We insert the
		_upgradePacket into the update_upgrades paramater.
		i) The called train cart will then call global.upgradeCompatabilities[$ object_get_name(object_index)]
			to find the cart's applicable upgrades.
			
		ii) It then loops through all applicable upgrades within the upgrade packet and calls upgrade_cart()
			for each one, giving the compatability (upgrade like "health" or "capacity") and the upgrade packet
			as paramaters
			1) upgrade_cart() then finds the upgrade packet value (for instance upgradePacket[$ "health"] = 150)
				and modifies the cart's variables from there
				
			1*) For some upgrades like "capacity", a number change won't always suffice, in which, you can also
				call functions within the switch statement within the upgrade_cart() function
*/
#endregion upgrade explanation

// Keys are the object index, inside the array, organized like this:
// [["upgradeName", max quantity], [...], ...]
global.upgradeCompatabilities = {
	obj_trainCartPassenger : ["health", "capacity"],
	obj_trainCartCoal : ["health"]
};

function get_cart_upgrade_compatabilities(_objectIndex) {
	return global.upgradeCompatabilities[$ object_get_name(_objectIndex)];
}

function generate_base_upgrade_packet() {
	return {
		"health" : 100,
		"efficiency" : 100,
		"capacity" : 1
	}
}

// Given a valid item enum, returns a string key for said item
// the string key can then be used to access the corresponding upgrade
// in the upgrade packet
function get_upgrade_class(_upgradeEnum) {
	switch(_upgradeEnum) {
		case ITEM.UPG_HEALTH: return "health";
		case ITEM.UPG_EFFICIENCY: return "efficiency";
		case ITEM.UPG_CAPACITY: return "capacity";
		default: 
			log("ERROR: Converting item enum to string, item is not valid!  Got: " + string(_upgradeEnum));
			return -1;
	}
}

// Given an upgrade item, returns the number benefit from having that item as an upgrade
// For instance, a health upgrade item will benefit the train with 50 health
function get_upgrade_benefit(_upgradeEnum) {
	switch(_upgradeEnum) {
		case ITEM.UPG_HEALTH: return 150;
		case ITEM.UPG_EFFICIENCY: return 125;
		case ITEM.UPG_CAPACITY: return 2;
	}
}

// Modifies cart values and calls functions based on the upgrade packet values 
// and the compatability given
function upgrade_cart(_upgradePacket) {
	
	log("got upgrade packet: " + string(_upgradePacket))
	
	// Loop through all compatible upgrades and set the cart's values according to the
	// upgrade packet
	
	// Get all compatibilities
	var _compatibilities = get_cart_upgrade_compatabilities(object_index);
	
	log("Compatibilities: " + string(_compatibilities));
	
	for (var i = 0; i < array_length(_compatibilities); i++) {
		var _compatibility = _compatibilities[i];
	}
	
	// Extract the new value based on the upgrade packet
	var _upgradeVal = _upgradePacket[$ _compatibility];
	
	// Modify the train numbers directly
	switch(_compatibility) {
		case "health":		max_cart_health		= _upgradeVal; break;
		case "efficiency":	cart_efficiency		= _upgradeVal; break;
		case "capacity":	cart_capacity_level	= _upgradeVal; 
							update_seats();				   break;
		default: log("ERROR: upgrade_cart() called with invalid _upgradeEnum");
	}
}