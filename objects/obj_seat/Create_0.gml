/// @description Insert description here
// You can write your code in this editor

// Variables given upon creation:
// facing -> -1 = left, 1 = right
// depth_modifier - a slight change in depth that sitting passengers add to their depth to
//					make sure the passengers are drawn in the correct order

// Stores the id of the passenger who owns this seat
current_passenger_id = noone;

function seat_assign_passenger(_passengerId) {
	current_passenger_id = _passengerId;
	current_passenger_id.depth += depth_modifier;
}

function seat_unassign_passenger() {
	
	// Make the passenger depart because the seat is no longer viable
	if (instance_exists(current_passenger_id)) {
		with(current_passenger_id) {
			queue_command(depart, id, 10);
		}
	
		current_passenger_id.depth -= depth_modifier;
	}
	
	current_passenger_id = noone;
}