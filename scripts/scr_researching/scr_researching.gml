
// Contains a list of all researched item enums
global.researched_items = [];
global.researchable_items = ds_list_create(); // A ds_list containing the item_enums as well as all the required items to research it
// Checks to see if a given item enum already exists within the researched_items array
/// @returns true if the item does exist, false if the item does not exist
function get_if_item_researched(_itemEnum) {
	for (var i = 0; i < array_length(global.researched_items); i++) {
		
		var _item = global.researched_items[i];
		if (_item == _itemEnum)
			return true;
	}
	
	return false;
}

function research_item(_itemEnum) {
	array_push(global.researched_items, _itemEnum);
}