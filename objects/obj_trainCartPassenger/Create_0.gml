/// @description Insert description here
// You can write your code in this editor







// Inherit the parent event - Unpack sprites, create cover, initialize health
event_inherited();

seat_ids = [];

// facing -> -1 = left, 1 = right
function pass_create_seat(_x, _facing) {
	
	
	var _id = instance_create_layer(_x, TRAIN_FLOOR_Y, "Cart_Interactables", obj_seat,
	{
		facing : _facing,
		image_xscale : _facing
	});
	
	array_push(seat_ids, _id);
}

function pass_get_max_capacity() {
	return array_length(seat_ids);
}

// Returns the id of an open seat if there is one
// Otherwise, returns -1
function pass_get_open_seat() {
	for (var i = 0; i < array_length(seat_ids); i++) {
		var _seatId = seat_ids[i];
		
		if (_seatId.current_passenger_id == noone) {
			return _seatId;	
		}
	}
	
	return -1;
}
