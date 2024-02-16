/// @description Insert description here
// You can write your code in this editor

ds_list_destroy(command_queue);
ds_grid_destroy(inventory_id);


// Remove Id from passenger list
with(obj_passengerController) {
	var _passengerIdPosition = ds_list_find_index(passenger_ids, other.id);
	ds_list_delete(passenger_ids, _passengerIdPosition);
}
	
// Remove Ownership From Seat
if (instance_exists(passenger_seat)) {
	with (passenger_seat) {
		seat_unassign_passenger();
	}
}