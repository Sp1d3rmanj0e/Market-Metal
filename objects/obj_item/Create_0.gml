/// @description Insert description here
// You can write your code in this editor
event_inherited(); // Store initial location on map

// Set to random color (TODO: Remove this)
randomize();
image_blend = make_color_rgb(random(255), random(255), random(255))

// Choose a random momentum upon being created
vsp = irandom_range(-5, 5);
hsp = irandom_range(-5, 5);

// Default vars if an error were to occur in its creation
text = "ItemName";
item_id = ITEM.NONE;
