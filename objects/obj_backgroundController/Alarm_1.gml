/// @description Spawn Clouds

var _spawnX = camera_get_view_x(get_side_camera()) + camera_get_view_width(get_side_camera()) + sprite_get_width(obj_cloud);

instance_create_layer(_spawnX, 0, "Decorations", obj_cloud);

alarm[1] = irandom_range(2*room_speed, 8 * room_speed);