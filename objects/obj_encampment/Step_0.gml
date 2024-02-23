/// @description Detect when train is close to station

if (abs(global.train_x - map_x) + abs(global.train_y - map_y) < 500) {
	//log("IT'S CLOSE!!!!");
	close_to_train = true;
} else {
	close_to_train = false;
}