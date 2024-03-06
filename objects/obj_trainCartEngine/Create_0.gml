/// @description Insert description here
// You can write your code in this editor

event_inherited(); // Initializing outside cover fading

alarm[0] = 1;

// Create the entrance/exit object if the cart is an engine
instance_create_layer(x-250, TRAIN_FLOOR_Y, "Instances", obj_trainExit,
{
	engine_id : id
});

crafting_research_gui_open = false;
crafting_research_id = noone;