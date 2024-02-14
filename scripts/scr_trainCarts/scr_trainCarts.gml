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

#region storage
// Returns an array with all the storage cart ids
function get_all_storage_cart_ids() {
	var _storageCartIds = [];
	
	// Add all storage cart ids to an array
	for (var i = 0; i < instance_number(obj_trainCartStorage); i++) {
		array_push(_storageCartIds, instance_find(obj_trainCartStorage, i));
	}
	
	return _storageCartIds;
}

// Returns the id of a storage cart with space
// If there is no space, it returns false
function get_storage_cart_id_with_space() {
	
	// Get the ids of every storage cart
	var _storageCartIds = get_all_storage_cart_ids();
	
	// Returns the id of the first storage cart with space in it
	for (var i = 0; i < array_length(_storageCartIds); i++) {
		var _cartId = _storageCartIds[i];
		
		if (is_there_storage_space_left(_cartId)) {
			return _cartId;
		}
	}
	
	return false;
}

// Returns True if there is space left and false if not
function is_there_storage_space_left(_cartId) {
	
	var _inventoryId = _cartId.inventory_id;
	
	return (inventory_get_number_open_slots(_inventoryId) != 0);
}
#endregion storage cart

#region passenger

// TODO: Merge with the other instance finder function
// Adds every passenger cart id into an array
function pass_get_cart_ids() {
	var _passCartIds = [];
	
	for (var i = 0; i < instance_number(obj_trainCartPassenger); i++) {
		array_push(_passCartIds, instance_find(obj_trainCartPassenger, i));
	}
	
	return _passCartIds;
}

function pass_find_seat() {
	
	// Get all the ids of passenger carts
	var _passCartIds = pass_get_cart_ids();
	
	for (var i = 0; i < array_length(_passCartIds); i++) {
		
		// Get a passenger cart id
		var _passId = _passCartIds[i];
		
		
		// TODO TODO TODO QWERTY
		var _openSeat
		
		if (_passId.pass_get_open_seat() != -1) {
			
		}
	}
}

#endregion passenger