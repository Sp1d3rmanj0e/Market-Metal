/// @description Insert description here
// You can write your code in this editor

global.P_System=part_system_create_layer(layer, true);

// Snow
global.ParticleSnow = part_type_create();
//part_type_shape(global.Particle1, pt_shape_line);
//part_type_size(global.Particle1, 0.01, 0.05, 0, 0.5);
part_type_alpha3(global.ParticleSnow, 1, 0.9, 0);
part_type_speed(global.ParticleSnow, 1, 2, 0, 0);
part_type_direction(global.ParticleSnow, 270, 280, 0.01, 0);
//part_type_blend(global.Particle1, true);
part_type_color3(global.ParticleSnow, c_white, c_ltgray, c_white);
part_type_life(global.ParticleSnow, 400, 600);
part_type_sprite(global.ParticleSnow, spr_particleSnow, false, false, true);
part_type_orientation(global.ParticleSnow, 0, 359, 1, 1, 0);

// Rain
global.ParticleRain = part_type_create();
//part_type_shape(global.Particle1, pt_shape_line);
//part_type_size(global.Particle1, 0.01, 0.05, 0, 0.5);
part_type_alpha3(global.ParticleRain, 0.5, 0.7, 0.3);
part_type_speed(global.ParticleRain, 4, 7, 0, 0);
part_type_direction(global.ParticleRain, 270, 280, 0, 0);
//part_type_blend(global.Particle1, true);
part_type_color3(global.ParticleRain, c_white, c_ltgray, c_white);
part_type_life(global.ParticleRain, 200, 200);
part_type_sprite(global.ParticleRain, spr_particleRaindrop, false, false, true);


// Sand
global.ParticleSand = part_type_create();
//part_type_shape(global.Particle1, pt_shape_line);
part_type_size(global.ParticleSand, 4, 12, 0, 0.02);
part_type_alpha3(global.ParticleSand, 0.1, 0.05, 0.1);
part_type_speed(global.ParticleSand, 4, 6, 0, 0);
part_type_direction(global.ParticleSand, 175, 185, 0, 5);
//part_type_blend(global.ParticleSand, true);
part_type_color3(global.ParticleSand, c_white, c_ltgray, c_orange);
part_type_life(global.ParticleSand, 600, 800);
part_type_sprite(global.ParticleSand, spr_particleSand2, false, false, true);
part_type_orientation(global.ParticleSand, 180, 180, 0.02, 0.01, true);


// Maple Leaves
global.ParticleMapleLeaves = part_type_create();
//part_type_shape(global.ParticleMapleLeaves, pt_shape_line);
part_type_size(global.ParticleMapleLeaves, 0.09, 0.02, 0, 0.02);
part_type_alpha2(global.ParticleMapleLeaves, 1, 0.00);
part_type_speed(global.ParticleMapleLeaves, 0.3, 0.6, 0, 0);
part_type_direction(global.ParticleMapleLeaves, 260, 280, 0.01, 0.1);
//part_type_blend(global.ParticleMapleLeaves, true);
part_type_color3(global.ParticleMapleLeaves, c_white, c_yellow, c_green);
part_type_life(global.ParticleMapleLeaves, 60, 120);
part_type_sprite(global.ParticleMapleLeaves, spr_effectMapleLeaf, false, false, true);
part_type_orientation(global.ParticleMapleLeaves, 0, 359, 1, 0, 0);

// Maple Leaves
global.ParticleSmokeCloud = part_type_create();
//part_type_shape(global.ParticleSmokeCloud, pt_shape_line);
part_type_size(global.ParticleSmokeCloud, 0.09, 0.02, 0.01, 0);
part_type_alpha2(global.ParticleSmokeCloud, 1, 0.00);
part_type_speed(global.ParticleSmokeCloud, 0.5, 1, 0, 0);
part_type_direction(global.ParticleSmokeCloud, 72, 98, 0.15, 0.1);
part_type_blend(global.ParticleSmokeCloud, true);
part_type_color3(global.ParticleSmokeCloud, c_dkgrey, c_ltgray, c_white);
part_type_life(global.ParticleSmokeCloud, 80, 180);
part_type_sprite(global.ParticleSmokeCloud, spr_effectSmoke, false, false, true);
part_type_orientation(global.ParticleSmokeCloud, 0, 359, 0.1, 0, 0);

alarm[0] = 1;