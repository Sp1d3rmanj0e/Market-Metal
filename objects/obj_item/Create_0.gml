/// @description Insert description here
// You can write your code in this editor

// Variables given before creation:
// item_map >>> Stores the "enum", "name", "sprite", "qty", and "desc" in a dictionary

// Unpack the map
item_enum = item_map[$ "enum"];
name = item_map[$ "name"];
sprite_index = item_map[$ "sprite"];

event_inherited(); // Store initial location on map

// Set to random color (TODO: Remove this)
randomize();
image_blend = make_color_rgb(random(255), random(255), random(255))

// Choose a random momentum upon being created
vsp = irandom_range(-5, 5);
hsp = irandom_range(-5, 5);

with(obj_taskController) {
	request_task(collect_item, other.id, 1, PROF.NONE);
}