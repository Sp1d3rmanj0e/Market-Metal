/// @description Increment crossface (If needed)

if (crossfade < 1) {
	crossfade += 1/60/room_speed; // Increase by 1 over an entire minute
} else {
	crossfade = 1;
}

