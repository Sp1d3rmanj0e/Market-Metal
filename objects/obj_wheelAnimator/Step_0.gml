/// @description Insert description here
// You can write your code in this editor

// Wheel frame speed
global.wheelFrame = (global.wheelFrame+global.trainSpeed)%(sprite_get_number(spr_trainWheels));