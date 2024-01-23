/// @description Insert description here
// You can write your code in this editor

global.P_System=part_system_create_layer(layer, true);
global.Particle1 = part_type_create();
//part_type_shape(global.Particle1, pt_shape_line);
//part_type_size(global.Particle1, 0.01, 0.05, 0, 0.5);
part_type_alpha3(global.Particle1, 1, 0.9, 0);
part_type_speed(global.Particle1, 1, 2, 0, 0);
part_type_direction(global.Particle1, 270, 280, 0.01, 0);
//part_type_blend(global.Particle1, true);
part_type_life(global.Particle1, 900, 1000);
part_type_sprite(global.Particle1, spr_particleSnow, false, false, true);
part_type_orientation(global.Particle1, 0, 359, 1, 1, 0);

alarm[0] = 1;