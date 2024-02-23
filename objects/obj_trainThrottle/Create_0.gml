/// @description Insert description here
// You can write your code in this editor

throttle_grabbed = false;

min_y = CONTROL_BOTTOM_Y - 10;
max_y = CONTROL_TOP_Y + 10;
mid_y = (min_y + max_y)/2;

max_thrust_y = (max_y-min_y)/2;

cur_y = mid_y;

// Returns a number between -1 to 1, with -1 being max reverse and 1 being max forward
function get_throttle_amount() {
	
	// Subtract the midpoint from the current throttle to switch from a
	// 0  -  x   throttle to a  
	// -x - +x   throttle
	var _zeroedThrottle = cur_y - mid_y;
	
	var _percentToMax = _zeroedThrottle/max_thrust_y;
	
	return _percentToMax;
}