
enum RESOURCE {
	// Trees
	BURNT_TREE,
	MAPLE_TREE,
	OLD_TREE,
	PALM_TREE,
	PINE_TREE,
	SWAMP_TREE,
	TROPICAL_TREE,
	OAK_TREE,
	
	// Ores
	COPPER_ORE,
	GOLD_ORE,
	IRON_ORE,
	
	// Special
	CACTUS
}

function get_resource_sprite_from_enum(_enum) {
	switch(_enum) {
		case RESOURCE.BURNT_TREE:		return		spr_burnt_tree;		break;
		case RESOURCE.MAPLE_TREE:		return		spr_maple_tree;		break;
		case RESOURCE.OLD_TREE:			return		spr_old_tree;		break;
		case RESOURCE.PALM_TREE:		return		spr_palm_tree;		break;
		case RESOURCE.PINE_TREE:		return		spr_pine_tree;		break;
		case RESOURCE.SWAMP_TREE:		return		spr_swamp_tree;		break;
		case RESOURCE.TROPICAL_TREE:	return		spr_tropical_tree;	break;
		case RESOURCE.OAK_TREE:			return		spr_oak_tree;		break;
												
		case RESOURCE.COPPER_ORE:		return		spr_copper_ore;		break;
		case RESOURCE.GOLD_ORE:			return		spr_gold_ore;		break;
		case RESOURCE.IRON_ORE:			return		spr_iron_ore;		break;
															
		case RESOURCE.CACTUS:			return		spr_cactus;			break;
															
		default: return spr_error;
	}
}

function get_resource_drops_from_enum(_enum) {
	switch(_enum) {
		case RESOURCE.BURNT_TREE:		return [[ITEM.WOOD, 2], [ITEM.COAL, 3]]; break;
		case RESOURCE.MAPLE_TREE:		return [[ITEM.WOOD, 4], [ITEM.FOLIAGE, 1]]; break;
		case RESOURCE.OLD_TREE:			return [[ITEM.WOOD, 5], [ITEM.FOLIAGE, 2]]; break;
		case RESOURCE.PALM_TREE:		return [[ITEM.WOOD, 3], [ITEM.FOLIAGE, 4]]; break;
		case RESOURCE.PINE_TREE:		return [[ITEM.WOOD, 4]]; break;
		case RESOURCE.SWAMP_TREE:		return [[ITEM.WOOD, 2], [ITEM.WATER, 1], [ITEM.FOLIAGE, 1]]; break;
		case RESOURCE.TROPICAL_TREE:	return [[ITEM.WOOD, 3], [ITEM.FOLIAGE, 3], [ITEM.VEGETABLES, 1]]; break;
		
		case RESOURCE.COPPER_ORE:		return [[ITEM.COPPER, 3], [ITEM.STONE, 2]]; break;
		case RESOURCE.GOLD_ORE:			return [[ITEM.GOLD, 2], [ITEM.STONE, 3]]; break;
		case RESOURCE.IRON_ORE:			return [[ITEM.IRON, 3], [ITEM.STONE, 2]]; break;
		
		case RESOURCE.CACTUS:			return [[ITEM.FOLIAGE, 4], [ITEM.WATER, 2]]; break;
		
		default: return [[]];
	}
}