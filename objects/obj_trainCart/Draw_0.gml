/// @description Insert description here
// You can write your code in this editor

// Draw the cart
draw_self();

draw_set_color(c_lime);
draw_line(x, y, mouse_x, mouse_y);
draw_set_color(-1);

// Draw the wheels
//draw_sprite(spr_trainWheels, global.wheelFrame, x, y)