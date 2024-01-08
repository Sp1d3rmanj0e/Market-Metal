// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum ITEM {
	
	// BASIC RESOURCES
	WOOD,
	STONE,
	COPPER,
	GOLD,
	IRON,
	TITANIUM,
	DIAMOND,
	
	// GLASS RESOURCES
	GLASS,
	PLEXIGLASS,
	
	// KEY CRAFTING
	MECHANICAL_PARTS,
	ELECTRICAL_PARTS,
	
	// SURVIVAL
	WATER,
	VEGETABLES,
	MEAT,
	
	// HEAT/COLD MANAGEMENT
	WOOL,
	AIR_CONDITIONING,
	
	// FUEL
	COAL,
	FOLIAGE,
	
	// COMBAT
	ARMOUR,
	HEALING_SALVE,
	WEAPONS,
	MAGNESIUM,
	FEATHERS,
	BOWS,
	ARROWS,
	
	// CURRENCY
	COINS
}

/*
function get_resource_data(_enum) {
	switch(_enum) {
		case RESOURCE.: return; break;
		case RESOURCE.: return; break;
		case RESOURCE.: return; break;
		case RESOURCE.: return; break;
		case RESOURCE.: return; break;
	}
}