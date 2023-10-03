/// @description Insert description here
// You can write your code in this editor

x = mouse_x;
y = mouse_y;

key_up		= keyboard_check(ord("W"));
key_left	= keyboard_check(ord("A"));
key_down	= keyboard_check(ord("S"));
key_right	= keyboard_check(ord("D"));

var _moveX = key_right - key_left;
var _moveY = key_down - key_up;

X += _moveX * moveSpeed;
Y += _moveY * moveSpeed;

