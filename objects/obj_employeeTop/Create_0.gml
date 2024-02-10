/// @description Insert description here
// You can write your code in this editor




// Store initial position upon creation for reference
event_inherited();

walk_speed = 5;

is_outdoors = true;

command_queue = ds_list_create();

inventory_id = create_inventory(2);
show_inventory = false;

inventory = ds_list_create();


function add_item_to_inventory(_id) {
	
	inventory_add_item_next_slot(inventory_id, _id);
	
}