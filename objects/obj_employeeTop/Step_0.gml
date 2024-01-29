/// @description Insert description here
// You can write your code in this editor

if (ds_list_size(command_queue) > 0) {

	// Get the top command to do
	var _nextCommandMap = ds_list_find_value(command_queue, 0);

	// Get the command and the target
	var _command = ds_map_find_value(_nextCommandMap, "command");
	var _target = ds_map_find_value(_nextCommandMap, "target");
	
	
	
	// Returns true if the command is completed
	if (!is_valid_target(_target) or _command(_target)) {
		ds_map_destroy(_nextCommandMap);
		ds_list_delete(command_queue, 0);	
	}
}