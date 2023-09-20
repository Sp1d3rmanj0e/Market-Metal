/// @description Insert description here
// You can write your code in this editor

// Create the wheel animator
if (!instance_exists(obj_wheelAnimator)) instance_create_layer(0, 0, "Instances", obj_wheelAnimator);

// Draw the engine if it's the first cart in the set
if (trainNumber == 1) sprite_index = spr_trainCartFront;
else sprite_index = spr_trainCartMulti;