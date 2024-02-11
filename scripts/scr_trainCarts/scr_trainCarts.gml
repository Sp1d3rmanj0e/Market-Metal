global.numCarts = 1;
global.trainSpeed = 0.1;
global.wheelFrame = 0;
global.currentCarts = [];
global.numPassengers = 0;

function get_train_max_capacity() {
	
	var _maxCapacity = 0;
	
	cart_ids = obj_trainController.cart_ids;
	
	for (var i = 0; i < array_length(cart_ids); i++) {
		
		var _cart = cart_ids[i];
		var _cartEnum = _cart.cart_enum;
		
		_maxCapacity += get_cart_max_capacity(_cartEnum);
	}
	
	return _maxCapacity;
}

function move_train_side(_amt) {
	
	with (par_trainCart) {
		x += _amt;
	}
	
	with (obj_employeeTop) {
		if (!is_outdoors) {
			x += _amt;
		}
	}
	
	with (par_movesAlongTrain) {
		x += _amt;
	}
}