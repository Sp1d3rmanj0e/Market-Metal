/// @description Add despawning mechanic


// Inherit the parent event
event_inherited();

despawn_counter = 2; // Goes down by 1 every time more resources get generated

// This function is called any time more resources are generated to prevent
// Data leaks
function decrement_despawn_timer() {
	despawn_counter--;
	if (despawn_counter == 0) instance_destroy();
}