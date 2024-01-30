/// @description Don't allow the chance to draw on main screen

// As soon as fade speed is reversed (We've reached full screen opacity)
// hide the train
if (sign(fade_speed) == 1)
	draw_self();