
#region status checkers

// Returns true if the bot is within range of the target
function too_far_from_target(_id) {
	if (distance_to_object(_id) > 10)
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
	
	// Move towards item before collecting it
	if (too_far_from_target(_id)) {
		queue_command_top(move_to_object, _id);
		return task_not_finished(); // Return false in order to prevent the code from collecting before we reach the destination
	}
	
	add_item_to_inventory(_id);
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
	locked_to_map = is_outdoors;
	return task_finished();
}

///@function teleport_to_object()
///@desc immediately moves an employee to a specific coordinate
function teleport_to_object(_id) {
	var _angleToObject = point_direction(x, y, _id.x, _id.y);
	var _distanceToObject = distance_to_object(_id);
	
	x_off += lengthdir_x(_distanceToObject, _angleToObject);
	y_off += lengthdir_y(_distanceToObject, _angleToObject);
	return task_finished();
}


///@function move_to_object()
///@desc Allow an employee to walk toward a specific object
// 1) If the employee is outside and the task is inside (or vice versa)
//	  the employee will first move to the train entrance/exit and switch
//	  its indoor/outdoor status
// 2) If close to the target, complete the task.  Otherwise, continue
//	  moving toward the target
function move_to_object(_id) {

	// Enter/leave the train if the task is on the other side
	if (_id != obj_trainEntrance) and (_id != obj_trainExit) and (_id.is_outdoors != is_outdoors) {
		
		queue_command_top(leave_or_enter_train, id); // We queue this one first in order for it to happen last
		
		if (!_id.is_outdoors) {
			queue_command_top(teleport_to_object, obj_trainExit);
			queue_command_top(move_to_object, obj_trainEntrance); // Go to the train to switch inside-outside
		} else {
			queue_command_top(teleport_to_object, obj_trainEntrance);
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
		var _moveDir = sign(_id.x - x); // -1 = left; 1 = right
		x_off += _moveDir * walk_speed;
		
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