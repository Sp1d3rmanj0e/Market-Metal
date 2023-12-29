/// @description Moving Carts

player_moving_left = keyboard_check(ord("A")) || keyboard_check(vk_left);
player_moving_right = keyboard_check(ord("D")) || keyboard_check(vk_right);

var _move = player_moving_right - player_moving_left;

with(obj_trainCart) {
	x += _move * other.player_move_speed_side_view;
}