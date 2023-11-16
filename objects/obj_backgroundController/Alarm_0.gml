/// @description Change Time And Background

time += 0.01;

// Loop to the next hour if the second is 60
if (time - floor(time) >= 0.60) time += 0.40;

// Loop to next day if the hour is 24
if (time >= 24) time = 0;

// Check to see if there are any background change triggers
// Only trigger if on an hour
if (round(time) - time == 0) {
	
	// Store the current background before any potential changes
	var _curBackground = current_background;
	
	// Get the upcoming background
	var _newBackground = backgrounds_time_of_day[time];

	// Check to see if the backgrounds are different - if so, crossfade them over the next hour
	if (_curBackground != _newBackground) {
		crossfade = 0;
	}

	// Update the backgrounds
	previous_background = _curBackground;
	current_background = _newBackground;
}
alarm[0] = room_speed/4;