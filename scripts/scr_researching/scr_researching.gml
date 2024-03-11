
// Contains a list of all researched item enums
global.researched_items = [];
global.researchable_items = ds_list_create(); // [itemEnum, [itemEnumReq, itemEnumReq, ...]]
global.researchable_items_that_need_confirmation = ds_list_create(); // [itemEnum, [itemEnumReq, itemEnumReq, ...]]

// Checks to see if a given item enum already exists within the researched_items array
/// @returns true if the item does exist, false if the item does not exist
function get_if_item_researched(_itemEnum) {
	
	// Loop through all of the already researched items
	for (var i = 0; i < array_length(global.researched_items); i++) {
		
		// Get an item from the array
		var _item = global.researched_items[i];
		
		// Check if any item in the array is the same as the one being checked
		
	}
}

// Add an item enum to the researched item list
function research_item(_itemEnum) {
	array_push(global.researched_items, _itemEnum);
}

// Will update the list of researchable_items_that_need_confirmation by checking
// if any items in the researchable_items list have all of their item research requirements met
// if so, it moves the item from researchable_items to researchable_items_that_need_confirmation
function check_if_new_items_are_researchable() {
	
	
}

/// @description - creates a dictionary containing the unlock item and the requirements to get that item
/// @param _itemToBeUnlocked - the item enum that will be unlocked once the reqs are met
/// @param _itemReqs - an array containing all the item enums required to unlock the _itemToBeUnlocked

/*
 * Get both the item that will be unlocked when the requirements are met
 * and the requirements to unlock those items
 *
 * Get the name of the item_enum so that we can make it's name the key to the dictionary
 * Then through that item name key, we can get the requirements of that item
 */

function create_research_item_profile(_itemToBeUnlocked, _itemReqs) {
	
	var _itemNameKey = get_item_data_from_enum(_itemToBeUnlocked, "name");
	
	ds_map_add(global.researchable_items, _itemNameKey, _itemReqs);
}

function load_researchable_items() {
	
	create_research_item_profile(ITEM.PLEXIGLASS, [ITEM.GLASS]);
}