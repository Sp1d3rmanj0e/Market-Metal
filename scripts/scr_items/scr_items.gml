// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum ITEM {
	
	NONE,
	
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

function spawn_item_qty(_name, _enum, _qty) {
	for (var _count = 0; _count < _qty; _count++) {
		spawn_item(_name, _enum);
	}
}

function spawn_item(_name, _enum) {
	instance_create_layer(x, y, "Resources", obj_item,
	{
		text : _name,
		item_id : _enum
	});
}

function get_item_name_from_enum(_enum) {
	switch(_enum) {
		case ITEM.NONE: return "None"; break;
		
		// BASIC RESOURCES
		case ITEM.WOOD: return "Wood"; break;
		case ITEM.STONE: return "Stone"; break;
		case ITEM.COPPER: return "Copper"; break;
		case ITEM.GOLD: return "Gold"; break;
		case ITEM.IRON: return "Iron"; break;
		case ITEM.TITANIUM: return "Titanium"; break;
		case ITEM.DIAMOND: return "Diamond"; break;
		
		// GLASS RESOURCES
		case ITEM.GLASS: return "Glass"; break;
		case ITEM.PLEXIGLASS: return "Plexiglass"; break;
		
		// KEY CRAFTING
		case ITEM.MECHANICAL_PARTS: return "Mechanical Parts"; break;
		case ITEM.ELECTRICAL_PARTS: return "Electrical Parts"; break;
		
		// SURVIVAL
		case ITEM.WATER: return "Water"; break;
		case ITEM.VEGETABLES: return "Vegetables"; break;
		case ITEM.MEAT: return "Meat"; break;
		
		// HEAT/COLD MANAGEMENT
		case ITEM.WOOL: return "Wool"; break;
		case ITEM.AIR_CONDITIONING: return "Air Conditioning"; break;

		// FUEL
		case ITEM.COAL: return "Coal"; break;
		case ITEM.FOLIAGE: return "Foliage"; break;

		// COMBAT
		case ITEM.ARMOUR: return "Armour"; break;
		case ITEM.HEALING_SALVE: return "Healing Salve"; break;
		case ITEM.WEAPONS: return "Weapons"; break;
		case ITEM.MAGNESIUM: return "Magnesium"; break;
		case ITEM.FEATHERS: return "Feathers"; break;
		case ITEM.BOWS: return "Bow"; break;
		case ITEM.ARROWS: return "Arrows"; break;

		// CURRENCY
		case ITEM.COINS: return "Coins"; break;
	}
	return "Error";
}