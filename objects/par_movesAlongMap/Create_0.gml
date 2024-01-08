/// @description Despawning and init

initial_x = x;
initial_y = y;

initial_map_cam_x = obj_mapController.map_cam_x;
initial_map_cam_y = obj_mapController.map_cam_y;

image_xscale = 2.5;
image_yscale = 2.5;

despawn_counter = 2; // Goes down by 1 every time more resources get generated

// This function is called any time more resources are generated to prevent
// Data leaks
function decrement_despawn_timer() {
	despawn_counter--;
	if (despawn_counter == 0) instance_destroy();
}