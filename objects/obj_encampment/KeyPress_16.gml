/// @description Insert description here
// You can write your code in this editor


if (close_to_train) {
	var _maxCapacity = get_train_max_capacity();

	if (global.numPassengers + 1 <= _maxCapacity) {
		global.numPassengers++;
	}
}