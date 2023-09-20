/// @description Functions & Set Up

map_open = false;

train_cam = view_camera[0];
map_cam = view_camera[1];

function setPrimaryCam(_camera) {
	view_set_camera(VIEW.MAIN, _camera);
}

function setSecondaryCam(_camera) {
	view_set_camera(VIEW.MINI, _camera);
}

function flipCams() {
	
	map_open = !map_open;

	if (map_open) {
		setPrimaryCam(map_cam);
		setSecondaryCam(train_cam);
	} else {
		setPrimaryCam(train_cam);
		setSecondaryCam(map_cam);
	}
}