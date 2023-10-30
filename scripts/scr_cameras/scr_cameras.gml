// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function get_map_camera() {
	if (obj_cameraManager.map_open) {
		return view_get_camera(VIEW.MAIN)
	}
	return view_get_camera(VIEW.MINI);
}