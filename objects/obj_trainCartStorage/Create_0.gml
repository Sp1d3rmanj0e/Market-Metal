/// @description Insert description here
// You can write your code in this editor










// Inherit the parent event - unpack sprites, create cart cover
event_inherited();

level = 1;

level_1_inv_id = create_inventory(4);
level_2_inv_id = create_inventory(4);
level_3_inv_id = create_inventory(8);

instance_create_layer(x - sprite_width/2, TRAIN_FLOOR_Y, "Instances", obj_storageBox);