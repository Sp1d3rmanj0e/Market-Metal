/// @description Insert description here
// You can write your code in this editor

// Ensure there is a spot for the passenger

// Find and get an available seat id
var _targetSeatId = pass_find_seat();

if (_targetSeatId != -1) {

	// Create a new passenger
	var _passengerId = instance_create_layer(obj_trainExit.x, TRAIN_FLOOR_Y, "Instances", obj_employeeTop,
	{
		profession : PROF.NONE, // Set to no profession
		is_outdoors : false,
		passenger_seat : _targetSeatId
	});

	// Add the passenger to an id array
	ds_list_add(passenger_ids, _passengerId);
	log("adding " + string(_passengerId) + "to list");
	log("list is now " + string(passenger_ids));
	log("it is " + string(ds_list_size(passenger_ids)) + " values long");

	// Tell the seat that a passenger owns that seat (So it can't be assigned to someone else)
	with (_targetSeatId) {seat_assign_passenger(_passengerId);}

	// Tell the passenger to move towards its new seat
	with(_passengerId) {
		queue_command(sit_down, _targetSeatId, 1);
	}
} else {
	log("ERROR: Tried to generate a passenger, but no spots available!");
}