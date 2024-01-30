/// @description Insert description here
// You can write your code in this editor

// Change color when hovering over the train
if (position_meeting(mouse_x, mouse_y, id)) and (!starting_game) {
	image_blend = c_ltgray;
} else {
	image_blend = c_white;
}

// Increase the speed of the train once pressed
if (starting_game) {
	hsp += 0.05;
}

// Allow the train to move once pressed
x += hsp;

// Once the train leaves the screen, fade to black
if (bbox_left > room_width) {
	fade_to_black = true;
}

// Increase fade over time when the train leaves the screen
if (fade_to_black)
	fade += fade_speed;

// Reverse the fade change after it reaches full opacity
if (fade >= 1) {
	room_goto(rm_main);
	fade = 0.99; // Immediately remove the ability for fade to trigger twice
	fade_speed = -fade_speed; // Reverse the fade change
}

if (fade <= 0) and (fade_to_black == true)
	instance_destroy();