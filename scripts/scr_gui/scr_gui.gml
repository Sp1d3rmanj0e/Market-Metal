

function draw_gui_background(_startX, _startY, _width, _height) {

	draw_sprite_stretched(spr_guiBackground, 0, _startX - 19, _startY - 19, _width + 38, _height + 38);
}

// Draws a text box and text on said box
function draw_gui_text_box(_startX, _startY, _width, _height, _text) {
	
	draw_sprite_stretched(spr_text_plate, 0, _startX, _startY, _width, _height);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	
	draw_text(_startX + _width/2, _startY + _height/2, _text);
	
	draw_set_halign(fa_left);
	draw_set_halign(fa_top);
}

function draw_gui_sub_gui(_startX, _startY, _width, _height) {
	draw_sprite_stretched(spr_sub_gui, 0, _startX, _startY, _width, _height);
}

// Draws a button that can be clicked
function draw_gui_button(_startX, _startY, _width, _height, _text = "", _function = -1) {
	
	var _color = c_ltgray;
	
	// Check if mouse is within button
	if (point_in_rectangle(mouse_x, mouse_y, _startX, _startY, _startX + _width, _startY + _height)) {
		_color = c_white;
		
		// Check if the button is clicked
		if (mouse_check_button_pressed(mb_left)) {
			mouse_clear(mb_left);
			
			log("clicked");
			
			_color = c_gray;
			
			// Activate the button script
			if (_function != -1)
				script_execute(_function);
		}
	}
	draw_sprite_stretched_ext(spr_button, 0, _startX, _startY, _width, _height, _color, 1);
	
	draw_set_color(c_black);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	
	draw_text(_startX + _width/2, _startY + _height/2, _text);
	
	draw_set_halign(fa_left);
	draw_set_halign(fa_top);
	
	draw_set_color(-1);
}


// Draws a GUI slider with a knob
/// @param _dir - 0 > Creates a left-right slider, anchored on the left side
///		   _dir - 1 > Creates an up-down slider, anchored at the top, and the bottom value is 0
/// @param _mouse > When calling this function, the second value in the array it returns should
///					be inserted in the mouse paramater.  It tells the slider that the knob is
///					actively being dragged by the mouse
/// @returns array[value between 0 and 1, _mouse (plug it back into the next instance of this function)]
function draw_gui_slider(_startX, _startY, _dir, _length, _val, _mouse) {
	
	var _circleX, _circleY;
	
	// Draw the current slider values
	if (_dir = 0) {
		
		// Draw the slider
		draw_sprite_stretched(spr_slider_strip, 0, _startX, _startY - 10, _length, 20);
							  
		// Calculate circle coordinates
		_circleX = _startX + (_length * _val);
		_circleY = _startY;
		
	} else {
		
		// Draw the slider
		draw_sprite_stretched(spr_slider_strip, 0, 
							  _startX - 10, _startY, 20, _length);
							  
		// Calcualte circle coordinates
		_circleX = _startX;
		_circleY = _startY + _length - (_length * _val)
	}
	
	// Draw the circle knob
	draw_sprite(spr_slider_knob, 0, _circleX, _circleY);
	
	// Initalize _newVal
	var _newVal = _val;
	
	// Check if the mouse is dragging the knob
	if (_mouse or point_in_circle(mouse_x, mouse_y, _circleX, _circleY, 38) 
				   and mouse_check_button(mb_left)) {
		
		// This becomes true if mouse was already true or should 
		// become true because it is clicked
		_mouse = true;
		
		// Adjust the knob according to the mouse movement,
		// then adjust the percent value accordingly
		if (_dir = 0) {
			_circleX = clamp(mouse_x, _startX, _startX + _length);
			_newVal = (_circleX - _startX) / _length;
		} else {
			_circleY = clamp(mouse_y, _startY, _startY + _length);
			_newVal = 1 - ((_circleY - _startY) / _length);
		}
	}
	
	// Returns a packet with the first value being a 0-1 value of the slider
	// and the second value being whether or not the mouse is actively dragging the slider
	return [_newVal, (!mouse_check_button_released(mb_left) and _mouse)];
}

enum GUI {
	NONE,
	INVENTORY
}