/// @description Insert description here
// You can write your code in this editor

previous_capacity_level = cart_capacity_level;





// Inherit the parent event - Unpack sprites, create cover, initialize health
event_inherited();

seat_ids = [];

// facing -> -1 = left, 1 = right
function pass_create_seat(_x, _facing, _depth) {
	
	
	var _id = instance_create_layer(_x, TRAIN_FLOOR_Y, "Cart_Interactables", obj_seat,
	{
		facing : _facing,
		image_xscale : _facing,
		depth_modifier : _depth
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

// Changes the amount of seats in the passenger cart based on the
// current cart_capacity_level
function update_seats() {
	log("CALLED");
	
	// Only call the updates if changes to the cart level have actually been made
	if (previous_capacity_level != cart_capacity_level) {
		
		// Update the amount of seats
		
		// Cart was downgraded
		if (previous_capacity_level > cart_capacity_level) {
			switch (cart_capacity_level) {
				case 1:
					destroy_all_seats_above_level(0);
				break;
				case 2:
					destroy_all_seats_above_level(1);
				break;
			}
		} else { // Cart was upgraded
			switch (cart_capacity_level) {
				case 2:
					create_seat_section_2();
				break;
				case 3:
					create_seat_section_3();
				break;
			}
		}
	
		// Update the cart level
		previous_capacity_level = cart_capacity_level;
		log("updating capacity!");
	} else {
		log("capacity never changed!");
	}
}

// This is usually called when the player removes a capacity upgrade
// from the passenger cart.  It will destroy all seats above the new
// level of the cart
function destroy_all_seats_above_level(_level) {
	
	log("Current number of seats: " + string(array_length(seat_ids)));
	
	// Start at the end of the array, where the higher level seats are
	// then move backwards from there.  Then once the seats are equal to or less than
	// the target level, the program stops
	for (var i = array_length(seat_ids)-1; i > 0; i--) {
		var _seatId = seat_ids[i];
		var _seatLevel = _seatId.depth_modifier;
		log("seat level: " + string(_seatLevel));
		
		if (_seatLevel > _level) {
			instance_destroy(_seatId);
			array_pop(seat_ids);
			log("seat level too high.  destroying");
		} else {
			log("seat level good. stoppping");
			break;
		}
	}
}

// Seat locations for level 1
function create_seat_section_1() {
	pass_create_seat(bbox_left + 44, 1, 0);
	pass_create_seat(bbox_left + 80, -1, 0);
	pass_create_seat(bbox_left + 110, 1, 0);
	pass_create_seat(bbox_left + 146, -1, 0);
	pass_create_seat(bbox_left + 176, 1, 0);
	pass_create_seat(bbox_left + 212, -1, 0);
}

// Extra seat locations for level 2
function create_seat_section_2() {
	pass_create_seat(bbox_left + 48, 1, 1);
	pass_create_seat(bbox_left + 76, -1, 1);
	pass_create_seat(bbox_left + 114, 1, 1);
	pass_create_seat(bbox_left + 142, -1, 1);
	pass_create_seat(bbox_left + 180, 1, 1);
	pass_create_seat(bbox_left + 208, -1, 1);
}

// Extra seat locations for level 3
function create_seat_section_3() {
	pass_create_seat(bbox_left + 52, 1, 2);
	pass_create_seat(bbox_left + 72, -1, 2);
	pass_create_seat(bbox_left + 118, 1, 2);
	pass_create_seat(bbox_left + 138, -1, 2);
	pass_create_seat(bbox_left + 184, 1, 2);
	pass_create_seat(bbox_left + 204, -1, 2);
}

create_seat_section_1();