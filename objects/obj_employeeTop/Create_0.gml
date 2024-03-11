/// @description Insert description here
// You can write your code in this editor

// Variables given before creation
// profession - PROF.enum
// is_outdoors - whether or not the bot is outdoors or not
// passenger_seat - the id of the seat they were assigned


// Store initial position upon creation for reference
event_inherited();

walk_speed = 5;

is_sitting = false;

command_queue = ds_list_create();

inventory_id = create_inventory(2);
show_inventory = false;

inventory = ds_list_create();

// Base stats
stat_speed		= random_probability_curve(1, 10);
stat_efficiency	= random_probability_curve(1, 10);
stat_metabolism	= random_probability_curve(1, 10);
stat_resilience	= random_probability_curve(1, 10);


function add_item_to_inventory(_id) {
	
	inventory_add_item_next_slot(inventory_id, _id);
	
}