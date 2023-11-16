/// @description Insert description here
// You can write your code in this editor

time = 9; // Time is in military.  Base 60.  Decimals represent the minutes

crossfade = 1;

alarm[0] = room_speed;

aurora_borealis = false;

function activate_aurora_borealis() {
	aurora_borealis = true;
}


enum BG {
	SUNRISE = 0,
	DAY		= 1,
	SUNSET	= 2,
	NIGHT	= 3,
	AURORA	= 4
}

previous_background = BG.SUNRISE
current_background = BG.DAY

backgrounds_time_of_day = [
BG.NIGHT,	// 0
BG.NIGHT,	// 1
BG.NIGHT,	// 2
BG.SUNRISE,	// 3
BG.SUNRISE,	// 4
BG.SUNRISE,	// 5
BG.SUNRISE,	// 6
BG.DAY,		// 7
BG.DAY,		// 8
BG.DAY,		// 9
BG.DAY,		// 10
BG.DAY,		// 11
BG.DAY,		// 12
BG.DAY,		// 13
BG.DAY,		// 14
BG.DAY,		// 15
BG.DAY,		// 16
BG.DAY,		// 17
BG.SUNSET,	// 18
BG.SUNSET,	// 19
BG.SUNSET,	// 20
BG.SUNSET,	// 21
BG.NIGHT,	// 22
BG.NIGHT	// 23
]