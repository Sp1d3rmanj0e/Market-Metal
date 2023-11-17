/// @description Smooth scrolling

if (target_zoom != map_zoom) {
	map_zoom += 0.2 * sign(target_zoom - map_zoom);
}