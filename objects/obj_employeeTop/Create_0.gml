/// @description Insert description here
// You can write your code in this editor




// Store initial position upon creation for reference
event_inherited();

walk_speed = 5;

is_outdoors = true;

command_queue = ds_list_create();

inventory = ds_list_create();


function add_item_to_inventory(_id) {
	ds_list_add(inventory, _id.item_id);
	instance_destroy(_id);
}