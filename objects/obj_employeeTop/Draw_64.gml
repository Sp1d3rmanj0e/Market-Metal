/// @description Insert description here
// You can write your code in this editor

draw_set_color(c_aqua);
for (var i = 0; i < ds_list_size(command_queue); i++) {
	
	// Get next command
	var _nextCommandMap = ds_list_find_value(command_queue, i);

	// Get the command and the target
	var _command = ds_map_find_value(_nextCommandMap, "command");
	var _target = ds_map_find_value(_nextCommandMap, "target");
	var _priority = ds_map_find_value(_nextCommandMap, "priority");
	
	var _commandName = script_get_name(_command);
	var _targetName = object_get_name(_target);
	var _priorityName = string(_priority);
	
	draw_text(0, 20*i, _priorityName + ": " + _commandName + " >>> " + _targetName);
}
draw_set_color(-1);