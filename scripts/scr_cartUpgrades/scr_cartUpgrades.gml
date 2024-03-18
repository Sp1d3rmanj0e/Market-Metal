
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