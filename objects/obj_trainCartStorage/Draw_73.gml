/// @description Insert description here
// You can write your code in this editor

var _camTopLeftX = camera_get_view_x(get_side_camera()) + 20;
var _camTopLeftY = camera_get_view_y(get_side_camera()) + 20;

if (show_inventory) {
	draw_inventory(inventory_id, _camTopLeftX, _camTopLeftY, 150, 150, 75, 2, 2, true);
	draw_inventory(obj_player.inventory_id, _camTopLeftX + 190, _camTopLeftY, 300, 150, 75, 2, 4, true);
}