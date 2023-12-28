/// @description Insert description here
// You can write your code in this editor

// Get side view player movements
player_move_left = keyboard_check(ord("A")) || keyboard_check(vk_left);
player_move_right = keyboard_check(ord("D")) || keyboard_check(vk_right);

// Get overall change in motion
var move = player_move_right - player_move_left;