
global.current_packet = noone;

function create_inventory(_size) {
	return ds_grid_create(1, _size);
}

function add_item(_inventoryId, _slot, _itemId, _name, _sprite, _quantity, _description) {
	
	// Create an item dictionary/map of its traits
	var _itemMap = generate_item_map(_itemId, _name, _sprite, _quantity, _description)
	
	// Add the item to the inventory
	ds_grid_add(_inventoryId, 0, _slot, _itemMap);
}

// Send the item back to its stored pick up point
// This is usually called when the item does not reach a valid
// destination
function inventory_return_picked_up_item(_packetId) {
	
	if (_packetId != noone) {
		// Get the stored pick up coordinates
		var _parentInventoryId = _packetId.parent_inventory_id;
		var _parentInventorySlot = _packetId.parent_inventory_slot;
	
		// Put the item in those coordinates
		inventory_put_item(_parentInventoryId, _parentInventorySlot, _packetId);
	}
}

// Draws the inventory to the screen
function draw_inventory(_inventoryId, _startX, _startY, _width, _height, _boxSize, _numRows, _numColumns) {
	
	draw_gui_background(_startX, _startY, _width, _height);
	
	// Track which box is being interacted with
	var _inventorySlotNum = 0;
	
	var _midX = _startX + _width/2;
	var _midY = _startY + _height/2;
	
	var _halfBoxesWidth = _boxSize * _numColumns / 2;
	var _halfBoxesHeight = _boxSize * _numRows / 2;
	
	_startX = _midX - _halfBoxesWidth;
	_startY = _midY - _halfBoxesHeight;
	
	for (var _column = 0; _column < _numColumns; _column++) {
	for (var _row = 0; _row < _numRows; _row++) {
		
		// Draw a slot in the inventory
		draw_box(_startX + _boxSize * _column, _startY + _boxSize * _row, _boxSize, _inventoryId, _inventorySlotNum);
		// Increase this number to tell the box which slot in the inventory it represents
		_inventorySlotNum++;
	}}
}

/// @returns A map containing the item's information
// If no grid exists, it will return 0
function inventory_get_item(_inventoryId, _slotNum) {
	
	return ds_grid_get(_inventoryId, 0, _slotNum);
}

// Reset the grid location back to default value
function inventory_remove_item(_inventoryId, _slotNum) {
	ds_grid_set(_inventoryId, 0, _slotNum, 0);
}

// Removes the packet from existence now that it is in an inventory
function delete_current_packet(_packetId) {
	
	// If the packet removed was the hand packet, set the hand to none
	if (_packetId == global.current_packet) {
		instance_destroy(global.current_packet);
		global.current_packet = noone;
	} else { // Otherwise, it was something like an item, which is not in the hand upon first collection
		instance_destroy(_packetId);
	}
}

// Puts an item packet into a designated inventory spot
function inventory_put_item(_inventoryId, _inventorySlotNum, _packetId) {
	
	// Get the item map from the packet
	var _itemMap = _packetId.item_map;
	
	// Unpack the packet
	var _itemId		= _itemMap[$ "id"];
	var _itemName	= _itemMap[$ "name"];
	var _itemSprite = _itemMap[$ "sprite"];
	var _itemQty	= _itemMap[$ "quantity"];
	var _itemDesc	= _itemMap[$ "desc"];
	
	// Add the item to the inventory
	add_item(_inventoryId, _inventorySlotNum, _itemId, _itemName, _itemSprite, _itemQty, _itemDesc);
	
	log("item added to inventory!");
	
	// Remove the packet from the player's hand to prevent item duplication
	// (and because the item is now in the inventory, it should not also be in the player's hand)
	delete_current_packet(_packetId);
	
	log("packet deleted!");
}

// Removes a targeted item from the inventory and creates an item packet storing the item's data
function pick_up_item(_inventoryId, _inventorySlotNum, _itemMap) {
	
	// Remove the item from the inventory
	inventory_remove_item(_inventoryId, _inventorySlotNum);
	log("item removed!");
	
	// Get the item information from this slot
	var _packetId = instance_create_layer(mouse_x, mouse_y, "Instances", obj_itemPacket,
	{
		parent_inventory_id : _inventoryId,
		parent_inventory_slot : _inventorySlotNum,
		item_map : _itemMap
	});
	log("packet created!")
	
	
	// Check to see if hand already has an item
	if (global.current_packet != noone) {
		
		// Give the new floating packet the old packet's last valid spot
		// We do this because the old packet just took the new packet's spot and
		// Will overwrite the old packet's spot if the new item were to be placed in an invalid spot
		// By switching them, the new packet will go to the old packet's original spot before taking
		// the new packet's spot
		var _incomingPacketId = global.current_packet;
		
		// Swap the pick up target of the items
		_packetId.parent_inventory_id = _incomingPacketId.parent_inventory_id;
		_packetId.parent_inventory_slot = _incomingPacketId.parent_inventory_slot;
		
		// Put the item that was currently in the player's hand into the targeted slot
		inventory_put_item(_inventoryId, _inventorySlotNum, global.current_packet);
		
		log("swapping items!");
	}
	
	// Pick up the item that is currently in the inventory slot
	global.current_packet = _packetId;
	log("packet collected! (made global var)");
}

function draw_box(_topLeftX, _topLeftY, _boxSize, _inventoryId, _inventorySlotNum) {
	
	var _mouseInBox = mouse_in_box(_topLeftX, _topLeftY, _boxSize);
	
	// Check if mouse is within the box
	if (_mouseInBox)
		draw_set_color(c_yellow);
	else
		draw_set_color(c_white);
		
	// Draw the box
	draw_rectangle(_topLeftX, _topLeftY, _topLeftX + _boxSize-1, _topLeftY + _boxSize-1, true);
	
	// Get the corresponding item based on its inventory slot number
	var _itemMap = inventory_get_item(_inventoryId, _inventorySlotNum);
	
	// Box is clicked
	if (mouse_check_button_pressed(mb_left)) and (_mouseInBox) {
		mouse_clear(mb_left);
		log("slot " + string(_inventorySlotNum) + " was clicked!");
		
		// If the cell is empty
		if (_itemMap == 0) {
			
			log("box was empty!");
			
			// And the hand is not empty
			if (global.current_packet != noone) {
				
				log("hand has an item");
				
				// Put the hand item into the cell
				inventory_put_item(_inventoryId, _inventorySlotNum, global.current_packet);
			}
		// The cell is not empty
		} else {
			
			log("was not empty!")
			
			// Handles both empty and non-empty hands
			pick_up_item(_inventoryId, _inventorySlotNum, _itemMap);
			
			log("ending command");
			return;
		}
	}
	
	// Don't load data if no data exists
	if (_itemMap != 0) {
		var _itemId		= _itemMap[$ "id"];
		var _itemName	= _itemMap[$ "name"];
		var _itemSprite = _itemMap[$ "sprite"];
		var _itemQty	= _itemMap[$ "quantity"];
		var _itemDesc	= _itemMap[$ "desc"];
	
		// Draw the icon (origin is in the top left)
		draw_sprite(_itemSprite, 0, _topLeftX, _topLeftY);
	
		// Draw the box text
		draw_set_halign(fa_center);
		draw_set_valign(fa_bottom);
	
		draw_text(_topLeftX + _boxSize/2, _topLeftY + _boxSize, _itemName);
	
		draw_set_halign(fa_right)
	
		draw_text(_topLeftX + _boxSize, _topLeftY + _boxSize, string(_itemQty));
	
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
}

// Returns if the mouse is in a box's square
function mouse_in_box(_topLeftX, _topLeftY, _boxSize) {
	return point_in_rectangle(
		mouse_x, mouse_y, 
		_topLeftX, _topLeftY,
		_topLeftX + _boxSize, 
		_topLeftY + _boxSize);
}

// Default value for an unoccupied cell is 0, so if it is not 0, return True
function inventory_slot_occupied(_inventoryId, _inventorySlotNum) {
	return (ds_grid_get(_inventoryId, 0, _inventorySlotNum) != 0)
}

// No open slot >>> Returns -1
// Open slot >>> Returns the location of the open slot
function inventory_has_space(_inventoryId) {
	
	// Search the inventory for an open slot
	for (var _slot = 0; _slot < ds_grid_height(_inventoryId); _slot++) {
		
		// If a slot if open, return the location of that spot
		if (!inventory_slot_occupied(_inventoryId, _slot)) {
			return _slot;
		}
	}
	
	return -1;
}

// No valid spots to place item >>> Returns false
// Slot found and placed >>> Returns true
function inventory_add_item_next_slot(_inventoryId, _packetId) {
	
	// Get the location of a valid spot in the inventory to place the item
	var _inventorySlotNum = inventory_has_space(_inventoryId);
	
	// No open spots
	if (_inventoryId == -1) { return false};
	
	inventory_put_item(_inventoryId, _inventorySlotNum, _packetId);
	
	return true;
}