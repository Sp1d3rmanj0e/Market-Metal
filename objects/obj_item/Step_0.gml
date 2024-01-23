/// @description Creation momentum and pick up

// Implement friction to motion
if (abs(hsp) > 0.1) {
	hsp *= 0.95;
} else {
	hsp = 0;
}

if (abs(vsp) > 0.1) {
	vsp *= 0.95;
} else {
	vsp = 0;
}

x_off += hsp;
y_off += vsp;

