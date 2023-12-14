/// @description Spawn Clouds

instance_create_layer(room_width, 0, "Decorations", obj_cloud);

alarm[1] = irandom_range(1*room_speed, 4 * room_speed);