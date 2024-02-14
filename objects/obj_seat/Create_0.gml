/// @description Insert description here
// You can write your code in this editor

// Variables given upon creation:
// facing -> -1 = left, 1 = right

// Stores the id of the passenger who owns this seat
current_passenger_id = noone;

function seat_assign_passenger(_passengerId) {
	current_passenger_id = _passengerId;
}

function seat_unassign_passenger() {
	current_passenger_id = noone;
}