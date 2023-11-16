/// @description Change Time And Background

time += 1;

if (time - floor(time) >= 0.60) time += 0.40;
if (time >= 24) time = 0;

alarm[0] = room_speed;