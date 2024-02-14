/// @description Insert description here
// You can write your code in this editor

log("attempting to activate");
for (var i = 0; i < ds_list_size(passenger_ids); i++) {
	log("test");
	var _passengerId = ds_list_find_value(passenger_ids, i);
	
	with(_passengerId) {
		queue_command(depart, id, 10);
	}
}