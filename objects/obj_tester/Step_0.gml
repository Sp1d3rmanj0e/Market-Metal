/// @description Insert description here
// You can write your code in this editor

if (camXOffset >= tileSize) {
	camXOffset = camXOffset mod tileSize;
	// Shift biomes to the left
	// Load new biomes there
}

camera_set_view_pos(view_camera[0], camXOffset, 480 - camYOffset);