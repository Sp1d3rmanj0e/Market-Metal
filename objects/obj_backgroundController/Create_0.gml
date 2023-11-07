/// @description Insert description here
// You can write your code in this editor

time = 9; // Time is in military.  Base 60.  Decimals represent the minutes

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

old_bg = BG.SUNRISE
new_bg = BG.DAY;
crossfade_old = 0;
crossfade_new = 1

function get_background() {
/**
 * The times are as follows:
 * 3 - 7 Sunrise
 * 7 - 18 Day
 * 18 - 22 Sunset
 * 22 - 3 Night/Aurora Borealis
 */
 
 if (time > 3 and time <= 7) {
	 
 }
 if (time > 7 and time <= 18) {
	 
 }
 if (time > 18 and time <= 22) {
	 
 }
 if (time > 22 or time <= 3) {
	 
 }
}