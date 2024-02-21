/// @description Insert description here
// You can write your code in this editor

if (ds_list_size(command_queue) > 0) {

	// Get the top command to do
	var _nextCommandMap = ds_list_find_value(command_queue, 0);
	var _listSize = ds_list_size(command_queue);
	
	// Get the command and the target
	var _command = ds_map_find_value(_nextCommandMap, "command");
	var _target = ds_map_find_value(_nextCommandMap, "target");
	
	var _priority = ds_map_find_value(_nextCommandMap, "priority");
	var _professionRestriction = ds_map_find_value(_nextCommandMap, "prof rest");
	
	// Returns true if the command is completed
	
	var _targetIsValid = is_valid_target(_target)
	var _commandResult = -1;
	
	// Only execute the command if the command has the CHANCE to work
	if (_targetIsValid) {
		
		// Execute the command and get a result
		// Possible outputs:
		// True  - the task is completed
		// False - the task is not yet completed
		// -1    - the task failed, must request again
		_commandResult = _command(_target);
	}
	
	// Remove the task from the list if the command is complete
	// or uncompleteable
	if (!_targetIsValid or _commandResult != false) {
		ds_map_destroy(_nextCommandMap);
		
		// Only delete the list if the player stil exists
		if (instance_exists(id))
			ds_list_delete(command_queue, 0);
	} 
	
	if (_commandResult == -1) { // Re-request the command through the task controller
		
		log("task failed");
		
		// Get the last parts of the command in order to send a full request back to the taskController
		
		
		with(obj_taskController) {
			request_task(_command, _target, 1, _professionRestriction);
		}
	}
}