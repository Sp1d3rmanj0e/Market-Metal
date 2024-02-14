
#region status checkers

// Returns true if the bot is within range of the target
function too_far_from_target(_id) {
	if (distance_to_object(_id) > walk_speed)
		return true;
	return false;
}

// Checks to make sure the target still exists
function is_valid_target(_id) {
	if (instance_exists(_id))
		return true;
	return false;
}

#endregion status checkers

#region command commands

function task_finished() {
	return true;	
}

function task_not_finished() {
	return false;
}

#endregion command commands

#region employee commands

/// @function collect_item()
// 1) Move to target if too far
// 2) Add item to inventory
function collect_item(_id) {
	
	// If there is no inventory space, empty out inventory first
	if (inventory_has_space(inventory_id) == -1) {
		
		// Find a cart to deposit items into 
		var _storageCartId = get_storage_cart_id_with_space();
		
		// If there is absolutely no space in the train, cancel this task
		if (_storageCartId == false) {
			return task_finished();
		}
		
		// Move to a storage cart and deposit items
		queue_command_top(deposit_items, id);
		
		return task_not_finished();
	}
	
	// Move towards item before collecting it
	if (too_far_from_target(_id)) {
		queue_command_top(move_to_object, _id);
		return task_not_finished(); // Return false in order to prevent the code from collecting before we reach the destination
	}
	
	add_item_to_inventory(_id);
	return task_finished();
}

function deposit_items(_employeeId) {
	
	// Get the id of a storage cart with space in it
	var _storageCartId = get_storage_cart_id_with_space();
	
	// Cancel task if there is no space to deposit items
	if (_storageCartId == false) {
		return task_finished();
	}

	// Move to the storage cart if too far away
	if (too_far_from_target(_storageCartId)) {
		queue_command_top(move_to_object, _storageCartId);
		return task_not_finished();
	}
	
	// Once next to the storage cart, find an item in your inventory to deposit
	
	// Get the item info
	var _itemSlot = inventory_get_first_filled_slot(_employeeId.inventory_id);
	var _itemMap = inventory_get_item(_employeeId.inventory_id, _itemSlot);
	
	// Remove the item from its current spot in the employee inventory
	inventory_remove_item(_employeeId.inventory_id, _itemSlot);
	
	// Get the storage cart inventoryId
	var _storageCartInventoryId = _storageCartId.inventory_id;
	
	// Add the item originally from the employee's inventory into the storage cart's inventory
	inventory_add_item_next_slot_map(_storageCartInventoryId, _itemMap);
	
	if (!inventory_is_empty(_employeeId.inventory_id)) {
		// Move towards item before collecting it
		return task_not_finished();
	}
	
	return task_finished();
}

// Puts a command at the top of the list
// This will usually be used to add a step/requirement to a command
function queue_command_top(_command, _target) {
	var _mapId = ds_map_create();
	ds_map_add(_mapId, "command", _command);
	ds_map_add(_mapId, "target", _target);
	ds_map_add(_mapId, "priority", 0);
	
	ds_list_insert(command_queue, 0, _mapId);
}

function queue_command(_command, _target, _priority) {
	
	var _mapId = ds_map_create();
	ds_map_add(_mapId, "command", _command);
	ds_map_add(_mapId, "target", _target);
	ds_map_add(_mapId, "priority", _priority)
	
	// Find where the command lies on the list of priorities
	for (var i = 0; i < ds_list_size(command_queue); i++) {
		
		// Get a command from the list
		var _nextCommandMap = ds_list_find_value(command_queue, i);
		
		// Find the command's priority
		var _nextCommandPriority = ds_map_find_value(_nextCommandMap, "priority");
		
		// If the command's priority is less than the new command's priority,
		// add the new command just above that one
		if (_priority > _nextCommandPriority) and (_nextCommandPriority != 0){
			ds_list_insert(command_queue, i, _mapId); // Insert the new command
			return
		}
	}
	
	// If the priority is equal to or less than the lowest priority on the list,
	// add it to the end
	ds_list_add(command_queue, _mapId);
}

///@function leave_or_enter_train()
///@desc changes the indoor/outdoor status of an employee
function leave_or_enter_train(_id) {
	is_outdoors = !is_outdoors;
	return task_finished();
}

///@function teleport_to_object()
///@desc immediately moves an employee to a specific coordinate
function teleport_to_object(_id) {
	set_coords_to(_id.x, _id.y, is_outdoors);
	return task_finished();
}

function set_coords_to(_targetX, _targetY, _isOutdoors) {
	
	if (_isOutdoors) {
		
		/*
		Functions were created by reverse engineering
		map movement calculations:
		
		x = initial_x - _changeInMapCamX + x_off;
		y = initial_y - _changeInMapCamY + y_off;
		*/
		
		var _currentMapCamX = obj_mapController.map_cam_x;
		var _currentMapCamY = obj_mapController.map_cam_y;

		var _changeInMapCamX = _currentMapCamX - id.initial_map_cam_x;
		var _changeInMapCamY = _currentMapCamY - id.initial_map_cam_y;
		
		x_off = _targetX + _changeInMapCamX - initial_x;
		y_off = _targetY + _changeInMapCamY - initial_y;
	} else {
		x = _targetX;
		y = _targetY;
	}
	
	
	
}


function sit_down(_target) {
	
	//move to the seat if not close enough
	if (too_far_from_target(_target)) {
		queue_command_top(move_to_object, _target);
		return task_not_finished();
	}
	
	// Get the direction that the seat is facing (-1 = left, 1 = right)
	image_xscale = _target.facing;
	
	is_sitting = true;
	x = _target.x;
}

///@function move_to_object()
///@desc Allow an employee to walk toward a specific object
// 1) If the employee is outside and the task is inside (or vice versa)
//	  the employee will first move to the train entrance/exit and switch
//	  its indoor/outdoor status
// 2) If close to the target, complete the task.  Otherwise, continue
//	  moving toward the target
function move_to_object(_id) {

	// Unsit if sitting
	if (is_sitting) {
		is_sitting = false;
	}
	
	
	// Enter/leave the train if the task is on the other side
	if (_id != obj_trainEntrance) and (_id != obj_trainExit) and (_id.is_outdoors != is_outdoors) {
		
		if (!_id.is_outdoors) {
			queue_command_top(teleport_to_object, obj_trainExit);
			queue_command_top(leave_or_enter_train, id); // We queue this one first in order for it to happen last
			queue_command_top(move_to_object, obj_trainEntrance); // Go to the train to switch inside-outside
		} else {
			queue_command_top(teleport_to_object, obj_trainEntrance);
			queue_command_top(leave_or_enter_train, id); // We queue this one first in order for it to happen last
			queue_command_top(move_to_object, obj_trainExit); // Go to the train to switch inside-outside
		
		}
	}
	
	
	// Finish objective if close to target
	if (!too_far_from_target(_id))
		return task_finished();
	
	// When outdoors, movement is 2d.  When indoors, movement is 1d
	if (is_outdoors) {
		
		// Move towards target
		var _directionToObject = point_direction(x, y, _id.x, _id.y);
	
		var _moveX = lengthdir_x(1, _directionToObject);
		var _moveY = lengthdir_y(1, _directionToObject);
	
		x_off += _moveX * walk_speed;
		y_off += _moveY * walk_speed;
	
		return task_not_finished();
	} else {
		x += sign(_id.x - x) * walk_speed;
		
		return task_not_finished();
	}
}

///@function mine_object()
///@desc Makes an employee move toward a harvestable object and use the mine command with it.
///		 once successful, the command will complete
function mine_object(_id) {
	
	// If the target is too far to mine the object, 
	// queue a move command first to get closer
	if (too_far_from_target(_id)) {
		queue_command_top(move_to_object, _id);
		return task_not_finished(); // Return false in order to prevent the code from mining before we reach the destination
	}
	
	with (_id) {
		// Execute the mine command until it returns true
		// The mine_object function is only completed when the mine function is completed
		return mine()
	}
}

#endregion employee commands