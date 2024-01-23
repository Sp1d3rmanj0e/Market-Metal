/// @description Move this somewhere else

// Get the potential item drops from this item
// This data is stored like this [[ITEM.ID, Qty], [ITEM.ID, Qty]]
var _drops = get_resource_drops_from_enum(resource_id);

if (array_length(_drops) > 0) {
	// Create each item respectively
	for (var _item = 0; _item < array_length(_drops); _item++) {
	
		// Get the array of this item
		// This data is stored like this [ITEM.ID, Qty]
		var _itemData = _drops[_item];
	
		// Separate the ITEM.ID and Quantity
		var _itemEnum = _itemData[0];
		var _itemQty = _itemData[1];
	
		// Get the item name
		var _itemName = get_item_name_from_enum(_itemEnum);
	
		spawn_item_qty(_itemName, _itemEnum, _itemQty);
	}
}

instance_destroy();





