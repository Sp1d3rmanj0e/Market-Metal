
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
	COINS,
	
	// UPGRADES
	UPG_HEALTH,
	UPG_EFFICIENCY,
	UPG_CAPACITY,
	
	// PROMOTIONS
	PRO_ATTENDANT,
	PRO_FARMER,
	PRO_FIGHTER,
	PRO_WORKER
}

function spawn_item_qty(_name, _enum, _qty) {
	for (var _count = 0; _count < _qty; _count++) {
		spawn_item(_name, _enum);
	}
}

function spawn_item(_name, _enum) {
	
	var _itemMap = generate_item_map(_enum, _name, get_item_data_from_enum(_enum, "sprite"), 1, "item does not yet have a description");
	
	instance_create_layer(x, y, "Resources", obj_item,
	{
		item_map : _itemMap
	});
}

// "sprite" will return the sprite of the item
// "name" will return the name of the item
function get_item_data_from_enum(_enum, _dataRequested) {
	
	var _itemPackage = [];
	
	switch(_enum) {
		case ITEM.NONE: _itemPackage = ["None", spr_itemError]; break;
		
		// BASIC RESOURCES
		case ITEM.WOOD:		_itemPackage = ["Wood", spr_wood_item]; break;
		case ITEM.STONE:	_itemPackage = ["Stone", spr_stone_item]; break;
		case ITEM.COPPER:	_itemPackage = ["Copper", spr_copper_item]; break;
		case ITEM.GOLD:		_itemPackage = ["Gold", spr_gold_item]; break;
		case ITEM.IRON:		_itemPackage = ["Iron", spr_iron_item]; break;
		case ITEM.TITANIUM: _itemPackage = ["Titanium", spr_titanium_item]; break;
		case ITEM.DIAMOND:	_itemPackage = ["Diamond", spr_diamond_item]; break;
										 
		// GLASS RESOURCES				 
		case ITEM.GLASS:	_itemPackage = ["Glass", spr_glass_item]; break;
		case ITEM.PLEXIGLASS: _itemPackage = ["Plexiglass", spr_plexiglass_item]; break;
		
		// KEY CRAFTING
		case ITEM.MECHANICAL_PARTS: _itemPackage = ["Mechanical Parts", spr_mechanical_parts]; break;
		case ITEM.ELECTRICAL_PARTS: _itemPackage = ["Electrical Parts", spr_mechanical_parts]; break;
		
		// SURVIVAL
		case ITEM.WATER: _itemPackage = ["Water", spr_water_item]; break;
		case ITEM.VEGETABLES: _itemPackage = ["Vegetables", spr_veggie_item]; break;
		case ITEM.MEAT: _itemPackage = ["Meat", spr_meat_item]; break;
		
		// HEAT/COLD MANAGEMENT
		case ITEM.WOOL: _itemPackage = ["Wool", spr_itemError]; break;
		case ITEM.AIR_CONDITIONING: _itemPackage = ["Air Conditioning", spr_AC_item]; break;

		// FUEL
		case ITEM.COAL: _itemPackage = ["Coal", spr_coal_item]; break;
		case ITEM.FOLIAGE: _itemPackage = ["Foliage", spr_foliage_item]; break;

		// COMBAT
		case ITEM.ARMOUR: _itemPackage = ["Armour", spr_itemError]; break;
		case ITEM.HEALING_SALVE: _itemPackage = ["Healing Salve", spr_healing_salve_item]; break;
		case ITEM.WEAPONS: _itemPackage = ["Weapons", spr_itemError]; break;
		case ITEM.MAGNESIUM: _itemPackage = ["Magnesium", spr_magnesium_item]; break;
		case ITEM.FEATHERS: _itemPackage = ["Feathers", spr_feather_item]; break;
		case ITEM.BOWS: _itemPackage = ["Bow", spr_bow_item]; break;
		case ITEM.ARROWS: _itemPackage = ["Arrows", spr_arrow_item]; break;

		// CURRENCY
		case ITEM.COINS: _itemPackage = ["Coins", spr_coin]; break;
		
		// UPGRADES
		case ITEM.UPG_HEALTH: _itemPackage = ["Health Upgrade", spr_itemError]; break;
		case ITEM.UPG_EFFICIENCY: _itemPackage = ["Efficiency Upgrade", spr_itemError]; break;
		case ITEM.UPG_CAPACITY: _itemPackage = ["Capacity Upgrade", spr_itemError]; break;
		
		// PROMOTIONS
		case ITEM.PRO_ATTENDANT: _itemPackage = ["Attendant Promotion", spr_itemError]; break;
		case ITEM.PRO_FARMER: _itemPackage = ["Farmer Promotion", spr_itemError]; break;
		case ITEM.PRO_FIGHTER: _itemPackage = ["Fighter Promotion", spr_itemError]; break;
		case ITEM.PRO_WORKER: _itemPackage = ["Worker Promotion", spr_itemError]; break;
		
		default: _itemPackage = ["Error", spr_itemError];
	}
	
	if (_dataRequested == "name")
		return _itemPackage[0];
	else return _itemPackage[1];
}

// Creates a map with all necessary data so it can
// safely enter inventory systems
function generate_item_map(_enum, _name, _sprite, _qty, _desc) {
	var _itemMap = {
		"id" : _enum,
		"name" : _name,
		"sprite" : _sprite,
		"quantity" : _qty,
		"desc" : _desc
	}
	
	return _itemMap;
}