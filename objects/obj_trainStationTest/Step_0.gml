/// @description Detect when train is close to station


// Inherit the parent event (Despawning and storing starting position)
event_inherited();

log("Train: (" + string(global.train_x) + ", " + string(global.train_y) + ")");
log("station: (" + string(map_x) + ", " + string(map_y) + ")");

if (abs(global.train_x - map_x) + abs(global.train_y - map_y) < 500) {
	log("IT'S CLOSE!!!!");
}