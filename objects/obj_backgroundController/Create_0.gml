/// @description Insert description here
// You can write your code in this editor

time = 16.50; // Time is in military.  Base 60.  Decimals represent the minutes

crossfade = 1;

alarm[0] = room_speed/2;
alarm[1] = 1;

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

// 0 = 0.0
// 12 = 0.5
// 24 = 1.0
function time_to_percent(_time) {
	
	// Turn the decimals from base 60 to base 100
	
	// Isolate the decimal
	var _minute = floor(_time);
	var _decimal = _time - _minute;
	
	// Switch to base 100
	// 30/60 = 50/100 (Multiply numerator by 5/3)
	_decimal = _decimal * (5/3);
	
	// Rejoin the decimal with the minute
	_time = _minute + _decimal;
	
	// Get the percentage completed by dividing by 24
	return _time/24;
}