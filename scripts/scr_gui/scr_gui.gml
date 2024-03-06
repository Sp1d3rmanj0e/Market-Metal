

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
	
	draw_set_color(c_white);
	
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
function draw_gui_slider(_startX, _startY, _dir, _length, _val, _mouse, _width = 20) {
	
	var _circleX, _circleY;
	
	// Draw the current slider values
	if (_dir = 0) {
		
		// Draw the slider
		draw_sprite_stretched(spr_slider_strip, 0, _startX, _startY - 10, _length, _width);
							  
		// Calculate circle coordinates
		_circleX = _startX + (_length * _val);
		_circleY = _startY;
		
	} else {
		
		// Draw the slider
		draw_sprite_stretched(spr_slider_strip, 0, 
							  _startX - 10, _startY, _width, _length);
							  
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


function gui_draw_passenger_exchange(_startX, _startY) {
	
	// Initialize
	var _width = 400;
	var _height = 430;
	
	// Background
	draw_gui_background(_startX, _startY, _width, _height);
	
	// Standardize boxes
	var _buffer = 10;
	var _boxWidth = 150;
	var _textBoxHeight = 45;
	
	// Top Left Text box
	draw_gui_text_box(_startX + _buffer, _startY + _buffer, 
					  _boxWidth, _textBoxHeight, "Text 1");
	
	// Top Right Text Box
	draw_gui_text_box(_startX + _width - _buffer - _boxWidth, _startY + _buffer, 
				      _boxWidth, _textBoxHeight, "Text 2");
	
	// Info Box Vars
	var _infoBoxY = _startY + _buffer*2 + _textBoxHeight;
	var _infoBoxHeight = 130;
	
	// Top Left Info Box
	draw_gui_sub_gui(_startX + _buffer, _infoBoxY, _boxWidth, _infoBoxHeight);
	
	// Top Right Info Box
	draw_gui_sub_gui(_startX + _width - _buffer - _boxWidth, _infoBoxY, _boxWidth, _infoBoxHeight);
	
	// Slider vars
	var _sliderWidth = 20;
	
	// Slider to choose amt of passengers to accept on the train
	draw_gui_slider(_startX + _width - _buffer*2 - _boxWidth - _sliderWidth, _startY + _buffer, 
					1, _textBoxHeight + _buffer + _infoBoxHeight, 0.5, true, _sliderWidth);
					
	// Bottom Text Box Vars
	var _bottomTextBoxY = _infoBoxY + _infoBoxHeight + _buffer;
	
	// Bottom Left Text Box
	draw_gui_text_box(_startX + _buffer, _bottomTextBoxY, 
					  _boxWidth, _textBoxHeight, "Text 3");
	
	// Bottom Right Text Box
	draw_gui_text_box(_startX + _width - _buffer - _boxWidth, _bottomTextBoxY, 
					  _boxWidth, _textBoxHeight, "Text 4");
	
	// Bottom Info Box Vars
	var _bottomInfoBoxY = _bottomTextBoxY + _textBoxHeight + _buffer;
	var _secondInfoBoxHeight = 90;
	
	// Bottom Left Info Box
	draw_gui_sub_gui(_startX + _buffer, _bottomInfoBoxY, 
					 _boxWidth, _secondInfoBoxHeight);
	
	// Bottom Right Info Box
	draw_gui_sub_gui(_startX + _width - _buffer - _boxWidth, _bottomInfoBoxY, 
					 _boxWidth, _secondInfoBoxHeight);
	
	// Button vars
	var _buttonWidth = 196;
	var _buttonHeight = 40;
	
	// Draw the exchange button
	draw_gui_button(_startX + _width/2 - _buttonWidth/2, _startY + _height - _buttonHeight - _buffer,
					_buttonWidth, _buttonHeight, "Exchange");
}

function gui_draw_cart_upgrade(_cartInvId, _playerInvId, _cartId) {
	
	/*		
			\/ Inventory
		+-------+ +---+
		|_|_|_|_| |_|_|
		| | | | | | | |
		+-------+ +---+
					/\ - Upgrade panel
	*/
	
	// Variables
	var _buffer = 20;
	var _invCellSize = 35;
	
	var _startX = camera_get_view_x(get_side_camera());
	var _startY = camera_get_view_y(get_side_camera());
	var _width = camera_get_view_width(get_side_camera());
	var _height = camera_get_view_height(get_side_camera());
	
	// Cart Upgrade Inventory
	draw_inventory(_cartInvId, _startX + _width - _buffer - _invCellSize*2, _startY + _height - _invCellSize*2 - _buffer,
				   _invCellSize*2, _invCellSize * 2, _invCellSize, 2, 2, true);
				   
	// Player Inventory 
	draw_inventory(_playerInvId, _startX + _buffer, _startY + _height - _invCellSize*2 - _buffer,
				   _invCellSize*4, _invCellSize * 2, _invCellSize, 2, 4, true);
}

function gui_draw_research_crafting(_playerInvId, _crafting = true) {
	
	/*
	
		+-----+ +-------+
		|__|__| |		|
		|__|__| |		|
		|__|__| |		|
		|  |  | |		|
		+-----+ +-------+
		^ - Inventory ^
					  | - Crafting/Research GUI
	*/
	
	// Reusable variables (ElementX and ElementY, for cleaner code)
	var _eX, _eY;

	// Variables
	var _buffer = 20;
	var _invCellSize = 80;
	
	var _startX = camera_get_view_x(get_side_camera()) + _buffer;
	var _startY = camera_get_view_y(get_side_camera()) + _buffer;
	var _width = camera_get_view_width(get_side_camera())  - _buffer*2;
	var _height = camera_get_view_height(get_side_camera())  - _buffer*2;
	
	// Draw the Inventory
	draw_inventory(_playerInvId, _startX, _startY, 
				   _invCellSize*2, _height,
				   _invCellSize, 4, 2, true);
	
	// Simplify variables with more specific ones
	var _rightSideWidth = _width - _invCellSize*2 - _buffer*2;
	var _rightSideStartX = _startX + _invCellSize*2 + _buffer*2;
	
	/*
				\/ _rightSideStartX
				I-------I - _rightSideWidth
		+-----+ +-------+
		|__|__| |		|
		|__|__| |		|
		|__|__| |		|
		|  |  | |		|
		+-----+ +-------+
		^ - Inventory ^
					  | - Crafting/Research GUI
	*/
	
	// Draw the right side background
	draw_gui_background(_rightSideStartX, _startY, _rightSideWidth, _height);
	
	// Button Vars
	var _smallBuffer = _buffer/4;
	var _buttonOffset = 20;
	var _buttonWidth = (_rightSideWidth - _smallBuffer*3)/2 - _buttonOffset*2; // x3 - 1 for left, right, and center buffers
	var _buttonHeight = 32;
	
	
	// Draw the tabs to switch between crafting and researching
	_eX = _rightSideStartX + _rightSideWidth/2 - _smallBuffer - _buttonWidth;
	_eY = _startY + _smallBuffer;
	
	draw_gui_button(_eX, _eY, _buttonWidth, _buttonHeight, "Crafting");
	
	_eX = _rightSideStartX + _rightSideWidth/2 + _smallBuffer;
	_eY = _startY + _smallBuffer;
	
	draw_gui_button(_eX, _eY, _buttonWidth, _buttonHeight, "Researching");
				
	if (_crafting) {
		
		// Bottom panel vars
		var _bottomStartY = _startY + _buttonHeight + _smallBuffer*2;
		var _bottomPanelHeight = _height - (_bottomStartY - _startY) - _smallBuffer;
		var _bottomPanelWidth = _rightSideWidth/2 - _smallBuffer*2;
		
		// Draw the recipes panel to the bottom left of the button
		_eX = _rightSideStartX + _rightSideWidth/2 - _bottomPanelWidth - _smallBuffer;
		_eY = _bottomStartY;
		
		draw_gui_sub_gui(_eX, _eY, _bottomPanelWidth, _bottomPanelHeight);
		
		// Draw the 
	}
	
	
}

enum GUI {
	NONE,
	UPGRADE,
	INVENTORY,
	CRAFTING
}