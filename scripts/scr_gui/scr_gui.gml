

function draw_gui_background(_startX, _startY, _width, _height, _subBackground = false) {
	if (!_subBackground)
		draw_sprite_stretched(spr_guiBackground, 0, _startX - 19, _startY - 19, _width + 38, _height + 38);
	else
		draw_sprite_stretched(spr_ui_border_2, 0, _startX - 19, _startY - 19, _width + 38, _height + 38);
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
	
	// Returns this value at the end of the function
	// Will change to true if clicked
	var _clicked = false;
	
	var _color = c_ltgray;
	
	// Check if mouse is within button
	if (point_in_rectangle(mouse_x, mouse_y, _startX, _startY, _startX + _width, _startY + _height)) {
		_color = c_white;
		
		// Check if the button is clicked
		if (mouse_check_button_pressed(mb_left)) {
			mouse_clear(mb_left);
			
			log("clicked");
			
			_color = c_gray;
			
			_clicked = true;
			
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
	
	return _clicked;
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

/// @param _playerInvId - inventory id of the player
/// @param _crafting - decides which tab to show, when true, shows the crafting inventory, when false, shows research
/// @param _craftingInventoryId - a 15-slot inventory used for crafting inputs
/// @param _craftingResultInventoryId - a 1-slot inventory used for crafting outputs
function gui_draw_research_crafting(_playerInvId, _crafting = true, _craftingInventoryId, _craftingResultInventoryId, _showCraftingResult) {
	
	#region diagram
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
	#endregion diagram
	
	#region initial variables
	
	// Reusable variables (ElementX and ElementY, for cleaner code)
	var _eX, _eY, _eW, _eH;

	// Variables
	var _buffer = 20;
	var _invCellSize = 80;
	
	var _startX = camera_get_view_x(get_side_camera()) + _buffer;
	var _startY = camera_get_view_y(get_side_camera()) + _buffer;
	var _width = camera_get_view_width(get_side_camera())  - _buffer*2;
	var _height = camera_get_view_height(get_side_camera())  - _buffer*2;
	
	#endregion initial variables
	
	// Draw the Player Inventory
	draw_inventory(_playerInvId, _startX, _startY, 
				   _invCellSize*2, _height,
				   _invCellSize, 4, 2, true);
	
	#region right side background
	
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
	
	#endregion right side background
	
	#region transitioing tabs/buttons
	
	// Button Vars
	var _smallBuffer = _buffer/4;
	var _buttonOffset = 20;
	var _buttonWidth = (_rightSideWidth - _smallBuffer*3)/2 - _buttonOffset*2; // x3 - 1 for left, right, and center buffers
	var _buttonHeight = 32;
	
	
	// Draw the tabs to switch between crafting and researching
	
	// Crafting tab button
	_eX = _rightSideStartX + _rightSideWidth/2 - _smallBuffer - _buttonWidth;
	_eY = _startY + _smallBuffer;
	
	if(draw_gui_button(_eX, _eY, _buttonWidth, _buttonHeight, "Crafting")
	and (_crafting == false)) {
		argument_2 = true;
	}
	
	// Researching Tab button
	_eX = _rightSideStartX + _rightSideWidth/2 + _smallBuffer;
	_eY = _startY + _smallBuffer;
	
	if (draw_gui_button(_eX, _eY, _buttonWidth, _buttonHeight, "Researching"))
	and (_crafting == true) {
		argument_2 = false; // Swaps crafting to false, resulting in the research menu being shown
	}
	
	// Draw tab divider
	_eX = _rightSideStartX + _buffer;
	_eY = _startY + _smallBuffer*2 + _buttonHeight;
	_eW = _rightSideWidth - _buffer*2;
	_eH = 7;
	
	draw_sprite_stretched(spr_divider, 0, _eX, _eY, _eW, _eH);
	
	#endregion transtitioning tabs/buttons
	
	// Bottom panel vars (moved outside the crafting section for reusability)
	var _bottomStartY = _startY + _buttonHeight + _smallBuffer*2 + _buffer; // Start of GUI below the section tabs
	var _bottomPanelHeight = _height - (_bottomStartY - _startY) - _smallBuffer; // The remaining height we can work with
	
	if (_crafting) {
		
		// Vars
		var _bottomPanelWidth = _rightSideWidth/2 - _smallBuffer*2; // The width of a panel (there are 2 panels)
		
		// Draw the recipes panel to the bottom left of the button
		var _recipePanelX = _rightSideStartX + _rightSideWidth/2 - _bottomPanelWidth - _smallBuffer;
		var _recipePanelY = _bottomStartY;
		draw_gui_sub_gui(_recipePanelX, _recipePanelY, _bottomPanelWidth, _bottomPanelHeight);
		
		// Draw the crafting menu!
		_eX = _rightSideStartX + _rightSideWidth/2 + _smallBuffer;
		_eY = _bottomStartY + _buttonHeight + _smallBuffer;
		var _craftingMenuHeight =  _bottomPanelHeight - _smallBuffer - _buttonHeight;
		draw_gui_sub_gui(_eX,  _eY, _bottomPanelWidth, _craftingMenuHeight);
		
		// Adjust _eX, _eY, and both widths to better suit the content inside the subGUI
		_buffer = 5; // Width of the gui border
		_eX += _buffer;
		_eY += _buffer;
		_bottomPanelWidth -= _buffer*2;
		_craftingMenuHeight -= _buffer*2;
		
		// Draw a tooltip over the crafting menu telling the user to place the recipe there
		// (only if a recipe is being focused)
		var _focusedRecipeID = get_if_a_recipe_is_focused(); // Returns -1 if no recipe is being focused
		
		// Recipe Selection
		if (_focusedRecipeID != -1) {
			
			// Draw a gray cover over the crafting menu
			draw_set_color(c_gray);
			draw_set_alpha(0.5);
			draw_rectangle(_eX, _eY, _eX + _bottomPanelWidth, _eY + _craftingMenuHeight, false);
		
			// Draw a black outline around the crafting menu if the recipe is not yet over it,
			// Draw a white outline if the recipe is over the crafting menu
			if (point_in_rectangle(_focusedRecipeID.x, _focusedRecipeID.y, 
								   _eX, _eY, _eX + _bottomPanelWidth, _eY + _craftingMenuHeight)) {
				draw_set_color(c_white);		
				
				// If the left mouse button is released while over the crafting menu, select it
				// Selecting it means that it will no longer be drawn while selected and instead will
				// have it's data extracted to form a recipe on the crafting table
				if (mouse_check_button_released(mb_left)
				and (inventory_is_empty(_craftingInventoryId))) {
					set_new_selected(_focusedRecipeID);
				}
			} else {
				draw_set_color(c_black);
			}
			
			draw_rectangle(_eX, _eY, _eX + _bottomPanelWidth, _eY + _craftingMenuHeight, true);
			
			// Draw text to tell the player to drop the recipe there
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			
			draw_text(_eX + _bottomPanelWidth/2, _eY + _craftingMenuHeight/2, "Place Recipe Here!");
			
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
		
			draw_set_alpha(1);
			draw_set_color(-1);
		}
		
		// Crafting table vars cont.
		_invCellSize = min((_bottomPanelWidth)/3, (_craftingMenuHeight)/4);
		
		#region draw recipe/inventory on the crafting table
		
		// If a recipe is selected, draw the recipe/inventory on the crafting table
		var _selectedRecipeID = get_current_selected_recipe();
		
		// Stores whether the inventory has all the needed components and no unneeded components
		// initialized here because if the inventory is actively showing the result and not the inventory,
		// or a crafting recipe isn't selected at all,
		// you shouldn't be able to craft anything
		var _inventoryIsComplete = false;
		
		// Only do this section if there is a selected recipe
		// Draws the crafting inventory
		if (_selectedRecipeID != -1) {
			
			// Extract the recipe instructions from the recipe
			var _selectedRecipeExpectedContents = _selectedRecipeID.get_recipe();
			
			// Draw the crafting table with the expected contents within
			// Returns true if the inventory has all required items and no extra items exist either
			if (!_showCraftingResult) {
				_inventoryIsComplete = draw_inventory(_craftingInventoryId, _eX, _eY,
							   _bottomPanelWidth, _craftingMenuHeight,
							   _invCellSize, 4, 3, false, _selectedRecipeExpectedContents);
			} else {
				
				// Draw the crafting result
				draw_inventory(_craftingResultInventoryId, _eX, _eY, _bottomPanelWidth, _craftingMenuHeight,
							   _invCellSize, 1, 1, false, -1);
							   
				// If the crafting result is empty, then switch back to the normal crafting menu
				if (inventory_is_empty(_craftingResultInventoryId))
					argument_5 = false; // Go back to crafting table instead of crafting result
			}
			
			#region cancel button
			
			// Adjust vars for the cancel button
			_eX += _bottomPanelWidth;
			_eY += _craftingMenuHeight;
			var _cancelButtonRadius = 25;
		
			// Give the player the ability to cancel crafting with a button
			// Positioned in the bottom right
			// Contains the sprite of the item that is currently being crafted
			// When the mouse hovers over the icon, an x will appear
			// When clicked, the recipe will be unselected (assuming the inventory is empty)
			draw_set_color(c_black);
			draw_circle(_eX, _eY, _cancelButtonRadius, false);
		
			// Coloristic flair by adding a second, white circle inside of the first black circle
			draw_set_color(c_white);
			draw_circle(_eX, _eY, _cancelButtonRadius-5, false);
			
			// Add vars for the content inside the circles
			// we subtract the _cancelButtonRadius/2 from _eX and _eY because _eX and _eY were 
			// the center points for the circle, but now we want them to the the top left and
			// top right points for the circle
			// _cBSX and _cBSY mean cancel button start x/y
			var _cBSX = _eX - _cancelButtonRadius/2;
			var _cBSY = _eY - _cancelButtonRadius/2;
			
			if (point_in_circle(mouse_x, mouse_y, _eX, _eY, _cancelButtonRadius)) {
				
				// Draw an X, telling the player they can cancel the craft
				draw_set_color(c_red);
				
				// TL -> BR
				draw_line_width(_cBSX, _cBSY, _cBSX + _cancelButtonRadius, _cBSY + _cancelButtonRadius, 5);
				
				// TR -> BL
				draw_line_width(_cBSX + _cancelButtonRadius, _cBSY, _cBSX, _cBSY + _cancelButtonRadius, 5);
				
				// Deselect the current recipe if the cancel button is pressed
				// (assuming the inventory is empty)
				if (mouse_check_button_pressed(mb_left)) {
				mouse_clear(mb_left);
					if (inventory_is_empty(_craftingInventoryId)) {
						_selectedRecipeID.reset_selected();
					}
				}
				
			} else {
				
				// Draw the item that you are actively crafting
				var _selectedRecipeSprite = get_item_data_from_enum(_selectedRecipeID.get_item(), "sprite");
				draw_sprite_stretched(_selectedRecipeSprite, 0, 
									  _cBSX, _cBSY, _cancelButtonRadius, _cancelButtonRadius);
			}
				
			draw_set_color(-1);
			
			#endregion cancel button

		}
		
		#endregion draw recipe/inventory on the crafting table
		
		#region "CRAFT!" button
		
		// Draw the "CRAFT!" button
		var _craftButtonX = _rightSideStartX + _rightSideWidth/2 + _smallBuffer;
		var _craftButtonY = _bottomStartY;
		var _craftButtonWidth = _bottomPanelWidth + _buffer*2;
		if (draw_gui_button(_craftButtonX, _craftButtonY, _craftButtonWidth, _buttonHeight, "CRAFT!")) {
			
			// If the button is pressed and the inventory has all the correct items, create the item
			// and switch to the crafting result screen
			if (_inventoryIsComplete) {
				
				// Extract craftable item details
				var _craftedItemEnum = _selectedRecipeID.get_item();
				var _craftedItemSprite = get_item_data_from_enum(_craftedItemEnum, "sprite");
				var _craftedItemName = get_item_data_from_enum(_craftedItemEnum, "name");
				
				// Add the crafted item to the inventory result screen
				add_item(_craftingResultInventoryId, 0, _selectedRecipeID.get_item(), _craftedItemName, _craftedItemSprite, 1, "dfdfsdf");
				
				argument_5 = true; // Switch to crafting result screen
				
				// Delete all current inventory items (as they are consumed in the crafting
				inventory_clear(_craftingInventoryId);
			}
		}
		
		#endregion "CRAFT!" button
		
		// Draw the recipes to to on top of the recipes panel
		// (Done last so that the items will appear on top)
		draw_all_recipes(_recipePanelX + 10, _recipePanelY+ 10, _bottomPanelWidth - 20, _bottomPanelHeight - 10, 50, 50, 3);
	
	} else { // Researching
		
		/*
		+-----------------------+
	    | Crafting  Researching |
	    |            +-+        |
	    | |Research| +-+        |
	    | +-------------------+ |
	    | | O... <-Item to get| |
	    | | A  <              | |
		| | B  <- Requirements| |
		| | C  <              | |
		| +-------------------+ |
	    +-----------------------+
		*/
		
		/* 
		
		Variables we can work with
		
		_startX				- start X of the entire GUI
		_startY				- start Y of the entire GUI
		_width				- width of the entire GUI
		_height				- height of the entire GUI
		_rightSideWidth		- width of the right section of the GUI
		_rightSideStartX	- start X of the right section of the GUI
		_buffer				- a standardized distance between elements and the GUI border
		_smallBuffer		- a smaller distance between elements within the GUI border
		_invCellSize		- a standard inventory size for the GUI
		_bottomStartY		- start of GUI below the section tabs
		_bottomPanelHeight  - the remaining height we can work with
		
		======================================
		
		Reusable variable names:
		
		_buttonWidth
		_buttonHeight
		_eX
		_eY
		
		*/
		
		// Inventory vars
		var _invStartX = _rightSideStartX + _rightSideWidth/2 - _invCellSize/2 + _buffer*3;
		var _invStartY = _bottomStartY + _buffer;
		
		// Draw a different background for the inventory
		draw_gui_background(_invStartX, _invStartY, _invCellSize, _invCellSize, true);
		
		// Draw the inventory in the middle of the right section
		draw_inventory(global.research_inventory, 
					   _invStartX, _invStartY, 
					   _invCellSize, _invCellSize, _invCellSize, 1, 1, false);
		
		// Button vars
		_buttonWidth = 140;
		_buttonHeight = 40;
		
		// Draw the research button
		if (draw_gui_button(_invStartX - _buttonWidth - _buffer*2, _invStartY + _invCellSize/2 - _buttonHeight/2, 
						_buttonWidth, _buttonHeight, "Research!")) {
			
			// Researches the item within the research inventory
			// (given there is an item in it, you can pay the cost, and the item hasn't been researched yet)
			
			if (!inventory_is_empty(global.research_inventory)) { // Make sure there is an item in the inventory
				
				log("Inventory is not empty");
				
				var _invItem = inventory_get_item(global.research_inventory, 0)[$ "id"];
				
				if (!item_already_researched(_invItem)) {
					log("Item: " + get_item_data_from_enum(_invItem, "name") + " wasn't already researched!");
					research_item(_invItem);
					inventory_remove_item(global.research_inventory, 0);
				}
			}
		}
						
		// Recipe section vars
		var _secondBottomStartY = _invStartY + _invCellSize + _buffer;
		var _secondBottomHeight = _bottomPanelHeight - _buffer*2 - _invCellSize;
		
		// Draw the sub GUI for all the recipes
		draw_gui_sub_gui(_rightSideStartX + _smallBuffer, _secondBottomStartY,
						 _rightSideWidth - _smallBuffer * 2, _secondBottomHeight);
						 
		// Draw the recipes
		#region draw the recipes 
		
		// Useful vars
		var _reqWidth = 20;
		var _recipe;
		
		// The total amount of recipes that haven't been confirmed yet
		var _recipeLength = ds_list_size(global.recipes_that_need_confirmation) + ds_list_size(global.researchable_recipes);
		
		// Loop through every recipe
		for (var i = 0; i < _recipeLength; i++) {
			
			// Calculate the position to draw the next recupe
			_eX = _rightSideStartX + (_reqWidth + _smallBuffer)*i + _buffer;
			
			// Start by drawing the recipes that need confirmation, then draw
			// the unfinished recipes
			if (i < ds_list_size(global.recipes_that_need_confirmation)) {
				
				// Get the recipe
				_recipe = ds_list_find_value(global.recipes_that_need_confirmation, i)
				
				// Draw the recipe
				if(draw_recipe_requirements(_eX, _secondBottomStartY + _smallBuffer*2,
									 _reqWidth, _recipe)) {
					confirm_recipe(_recipe);
					return
				}
			} else {
				
				// Get the recipe (subtracting the i value from the other array in order to index properly)
				_recipe = ds_list_find_value(global.researchable_recipes, i-ds_list_size(global.recipes_that_need_confirmation));
				
				// Draw the recipe
				if(draw_recipe_requirements(_eX, _secondBottomStartY + _smallBuffer*2,
									 _reqWidth, _recipe)) {
					confirm_recipe(_recipe);
					return
				}
			}
		}
		
		#endregion draw the recipes
	}
	
}

// Moves a recipe from global.recipes_that_need_confirmation to global.crafting_recipes
function confirm_recipe(_recipe) {
	// Find the spot the recipe currently resides
	var _index = ds_list_find_index(global.recipes_that_need_confirmation, _recipe);
			
	// Remove it from that list
	ds_list_delete(global.recipes_that_need_confirmation, _index);
			
	// Add it to the new list
	ds_list_add(global.crafting_recipes, _recipe);
}

// Used in gui_draw_research_crafting to draw the individual recipes that can be crafted
/// @returns true if all requirements are met and the button to confirm the recipe is pressed
function draw_recipe_requirements(_startX, _startY, _width, _recipe) {
	
	/*
	+-+
	+-+ <-- Item to get
	
	+-+
	+-+ <- Requirement
	+-+
	+-+ <- Requirement (Requirements that have been met have a green background)
	
	*/
	
	var _itemToGet = _recipe.get_item();
	var _requirements = _recipe.get_requirements();
	var _unlockable = _recipe.is_unlockable();
	
	// Draw the item to get on the top
	
	// Turn green if unlockable, otherwise gray
	if (_unlockable)
		draw_set_color(c_green);
	else
		draw_set_color(c_dkgray);
	
	// Draw backdrop
	draw_roundrect(_startX, _startY, _startX + _width, _startY + _width, false);
	
	if (_unlockable) {
		if (point_in_rectangle(mouse_x, mouse_y, _startX - 2, _startY - 2, _startX + _width + 2, _startY + _width + 2)) {
			
			draw_set_color(c_white);
		
			// If clicked to confirm the recipe, move to the ds_list called global.crafting_recipes
			if (mouse_check_button_pressed(mb_left)) {
				return true;
			}
		
		} else {
			draw_set_color(c_lime);
		}
		
		draw_roundrect(_startX - 2, _startY - 2, _startX + _width + 2, _startY + _width + 2, true);
	}
	
	// Draw the item sprite
	draw_set_color(-1);
	var _sprite = get_item_data_from_enum(_itemToGet, "sprite");
	draw_sprite_stretched(_sprite, 0, _startX, _startY, _width, _width);
	
	
	var _buffer = 5;
	
	// Draw all the remaining item requirements
	// Items that are already unlocked will be green, otherwise, they will be gray
	for (var i = 0; i < array_length(_requirements); i++) {
		var _requirement = _requirements[i];
		
		// Set color based on research status
		if (item_already_researched(_requirement))
			draw_set_color(c_green);
		else
			draw_set_color(c_dkgray);
			
		// Draw background
		var _elementY = _startY + _width + _buffer + _width*i; // Adds a spacer between the item to get 
															   // and the required items
		draw_roundrect(_startX, _elementY,
					   _startX + _width, _elementY + _width, false);
		
		// Draw the required item
		draw_set_color(-1);
		_sprite = get_item_data_from_enum(_requirement, "sprite");
		draw_sprite_stretched(_sprite, 0, _startX, _elementY, _width, _width);
	}
	
	return false;
}

function gui_draw_person_profile(_personId) {
	/*
	The person targeted will be centered in the profile
	Image slot in the top right
	
	\/ Origin
	
	X------------------------+
	|   [PassSklz]    +-----+|
	|                 |     || <- Image of passenger
	| O =========     |     ||
	| O =========     +--X--+| <- X is focused passenger origin
	| O =========     [Name-]|
	| O =========            |
	| +--+            {Stamp}|
	| |  |            [DistX]| <- Distance travelled on train
	| +--+  [View Inventory] |
	+------------------------+
		 /\
	      L Profession slot
	
	*/
	
	// Vars to signal the details of the card
	
	// The distance between the id card sprite's origin and the passenger origin
	// is 219 X, and 89 Y
	var _startX = _personId.x - 219;
	var _startY = _personId.y - 89;
	
	
	
	var _width = sprite_get_width(spr_id_card);
	var _height = sprite_get_height(spr_id_card);
	
	// Other vars
	var _buffer = 10;

	draw_sprite(spr_id_card, 0, _startX, _startY);
	
	
}

enum GUI {
	NONE,
	UPGRADE,
	INVENTORY,
	CRAFTING,
	PROFILE
}