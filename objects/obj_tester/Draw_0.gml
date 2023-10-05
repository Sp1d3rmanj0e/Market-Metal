/// @description Insert description here
// You can write your code in this editor

// Set random seed based on x and y coordinates
random_set_seed(Y + X * 123123.123123);

X = 0;
Y = irandom_range(0, room_height/64) * 64;

while (X < room_width) {
	
	// Set random seed based on x and y coordinates
	random_set_seed(Y + X * 123123.123123);
	
	// Loop until valid direction is picked
	while(true) {
		
		dir = choose(DIR.DOWN, DIR.RIGHT, DIR.RIGHT, DIR.RIGHT, DIR.RIGHT, DIR.RIGHT, DIR.UP);
		
		// Check if trying to either move down when facing up or move up when facing down
		if (dir+old_dir != 6) break;
	}
	
	
	
	// Move in direction of dir
	switch(dir) {
		case DIR.DOWN:
			draw_sprite(spr_tracks, 2, X, Y);
			Y += 64;
			break;
		case DIR.RIGHT:
			draw_sprite(spr_tracks, 1, X, Y);
			X += 64;
			break;
		case DIR.UP:
			draw_sprite(spr_tracks, 0, X, Y);
			Y -= 64;
			break;
	}
	
	// Set new old dir
	old_dir = dir;
}