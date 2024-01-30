/// @description Insert description here
// You can write your code in this editor

if (cart_enum == CARTS.ENGINE) {
	randomize();
	part_particles_create(global.P_System, x-52, y-85, global.ParticleSmokeCloud, 1);
	alarm[0] = irandom_range(20, 30);
}