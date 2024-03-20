
// Keys are the object index, inside the array, organized like this:
// [["upgradeName", max quantity], [...], ...]
global.upgradeCompatabilities = {
	obj_trainCartPassenger : [["health", 4], ["capacity", 3]]
};

function upgrade_enum_to_string(_upgradeEnum) {
	switch(_upgradeEnum) {
		case ITEM.UPG_HEALTH: return "health";
		case ITEM.UPG_EFFICIENCY: return "efficiency";
		case ITEM.UPG_CAPACITY: return "capacity";
	}
}

function upgrade_is_compatible(_compatabilityArr, _upgradeEnum) {
	for (var i = 0; i < array_length(_compatabilityArr); i++) {
		var _compatability = _compatabilityArr[i];
		
		if (_compatability == _upgradeEnum)
			return true;
	}
	
	return false;
}


function get_upgrade_benefit(_upgradeEnum) {
	switch(_upgradeEnum) {
		case ITEM.UPG_HEALTH: return 50;
		case ITEM.UPG_EFFICIENCY: return 25;
		case ITEM.UPG_CAPACITY: return 1;
	}
}

function generate_default_upgrade_packet() {
	return {
		"health" : 100,
		"efficiency" : 100,
		"capacity" : 1
	}
}

// Takes the current iteration of an upgrade packet, and decodes
// another upgrade item.  If the item is applicable, it will add
// its benefits to the upgrade packet and send it back
function update_upgrade_packet(_upgradePacket, _upgradeEnum) {
	
	var _upgradeKey = upgrade_enum_to_string(_upgradeEnum);
	var _upgradeBenefit = get_upgrade_benefit(_upgradeEnum);
	
	try {
		_upgradePacket[$ _upgradeKey] += _upgradeBenefit;
	} catch(e) {
		log("invalid item in upgrade slot");
	}
	
	return _upgradePacket;
}

function upgrade_cart(_compatability, _upgradePacket) {
	
	var _newVal = _upgradePacket[$ _compatability]; // Get the current value for that upgrade
	
	switch(_compatability) {
		case "health":		max_cart_health		= _newVal; break;
		case "efficiency":	cart_efficiency		= _newVal; break;
		case "capacity":	cart_capacity_level	= _newVal; 
							update_seats();				   break;
	}
}