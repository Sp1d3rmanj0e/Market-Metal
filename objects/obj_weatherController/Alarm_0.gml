/// @description Insert description here
// You can write your code in this editor

// Give weather effects based on biome

if (current_biome_name == "Desert") {

	// Sand Particles
	randomize();
	for (var i = -15; i < 300; i+= random(30)) {
		part_particles_create(global.P_System, 1350, i, global.ParticleSand, 1);
	}
	alarm[0] = irandom_range(5, 7);
} else if (current_biome_name == "Snow"){
	
	// Snow
	for ( i = 570; i < 1310; i+= 15) {
		part_particles_create(global.P_System, i, -350, global.ParticleSnow, 5);
	}

	randomize();
	alarm[0] = irandom_range(60, 90);
	
} else {
	
	// Check again in half a second
	alarm[0] = 30;
}