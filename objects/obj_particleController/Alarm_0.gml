
/* Snow
for (var i = 570; i < 1310; i+= 15) {
	part_particles_create(global.P_System, i, -350, global.ParticleSnow, 5);
}

randomize();
alarm[0] = irandom_range(60, 90);
*/

//620 1260

/* Heavy Rain
for (var i = 570; i < 1310; i+= random(5)) {
	part_particles_create(global.P_System, i, -350, global.ParticleRain, 5);
}

randomize();
alarm[0] = irandom_range(30, 35);
*/

/* Normal Rain
for (var i = 570; i < 1310; i+= random(15)) {
	part_particles_create(global.P_System, i, -350, global.ParticleRain, 5);
}

randomize();
alarm[0] = irandom_range(30, 35);
*/

/* Sand
randomize();
for (var i = -15; i < 300; i+= random(30)) {
	part_particles_create(global.P_System, 1350, i, global.ParticleSand, 1);
}
alarm[0] = irandom_range(5, 7);
*/

/* Maple Leaves
randomize();
part_particles_create(global.P_System, mouse_x, mouse_y, global.ParticleMapleLeaves, 1);
alarm[0] = irandom_range(60, 270);
*/

randomize();
part_particles_create(global.P_System, mouse_x, mouse_y, global.ParticleSmokeCloud, 1);
alarm[0] = irandom_range(20, 30);
