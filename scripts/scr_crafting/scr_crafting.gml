
/// @description - draws all craftable recipes within a given area.
///				   overflow recipes can be shown through a scroll bar
///				   NOTE: If the recipe is selected, it will not be drawn here
/// @param _startX, _startY - the top left of the box in which to draw the recipes
/// @param _boxWidth, _boxHeight - the zone in which recipes can be drawn
/// @param _recipeWidth, _recipeHeight - the size of the recipes to draw
/// @param _recipesPerRow - how many recipes will be drawn per row, elements will be centered within the bounding box
function draw_all_recipes(_startX, _startY, _boxWidth, _boxHeight, _recipeWidth, _recipeHeight, _recipesPerRow) {
	
	// Calculate buffer based on space given and number of recipes per row
	// NOTE: There will always be a buffer at the start and at the end of each row
	//		 and a buffer in between recipes
	var _amountOfBufferToOffer = _boxWidth - _recipeWidth*_recipesPerRow;
	var _buffer = _amountOfBufferToOffer / (_recipesPerRow+1);
	
	// Make sure the paramaters are good
	if (_amountOfBufferToOffer < 0) {
		log("ERROR: scr_crafting - Amount of space needed to draw recipes exceeds space given!");
		return false;
	}
	
	// Vars to store where to draw recipes
	var _drawX = _startX + _buffer;
	var _drawY = _startY + _buffer;
	var _numberOfRecipesDrawnThisRow = 0;

	// Stores the currently focused recipe to draw later
	var _focusedRecipe = noone;
	
	// Loops for all available recipes
	for (var i = 0; i < ds_list_size(global.crafting_recipes); i++) {
		var _recipe = ds_list_find_value(global.crafting_recipes, i);
		
		// Check if the recipe is focused
		// If it is, skip past it as it will be drawn later attached to the mouse
		if (!_recipe.get_focus() and !_recipe.get_selected()) {
			
			// Draw the next recipe
			_recipe.draw(_drawX, _drawY, _recipeWidth, _recipeHeight);
			
			_numberOfRecipesDrawnThisRow++;
		
			// Move the draw location to the next one
			_drawX += _recipeWidth + _buffer;
		
			// If the number of recipes drawn equals the target _recipesPerRow, 
			// then go to the next row
			if (_numberOfRecipesDrawnThisRow >= _recipesPerRow) {
				_drawX = _startX + _buffer; // Reset the row x
				_drawY += _recipeHeight + _buffer; // Move down a row
			
				_numberOfRecipesDrawnThisRow = 0; // Reset the counter
			}
		} else if (_recipe.get_focus()) {
			_focusedRecipe = _recipe; // Save the recipe to draw after everything else
									  // so that it will be drawn on top of everything
		}
	}
	
	// Draw the focused recipe last to draw it on top of everything
	if (_focusedRecipe != noone)
		_focusedRecipe.draw(mouse_x, mouse_y, _recipeWidth, _recipeHeight);
}

/// @description - finds if there is a focused recipe (player is actively dragging a recipe) or not
/// @returns - recipe ID if a recipe is being focused, false if no recipes are being focused
function get_if_a_recipe_is_focused() {
	for (var i = 0; i < ds_list_size(global.crafting_recipes); i++) {
		var _recipe = ds_list_find_value(global.crafting_recipes, i);
		
		if (_recipe.get_focus())
			return _recipe;
	}
	return -1;
}

function set_new_selected(_recipeID) {
	for (var i = 0; i < ds_list_size(global.crafting_recipes); i++) {
		var _recipe = ds_list_find_value(global.crafting_recipes, i);
		
		_recipe.reset_selected();
	}
	
	_recipeID.set_selected();
}

/// @returns recipe id if there is a currently selected recipe, otherwise, returns -1
function get_current_selected_recipe() {
	for (var i = 0; i < ds_list_size(global.crafting_recipes); i++) {
		var _recipe = ds_list_find_value(global.crafting_recipes, i);
		
		if(_recipe.get_selected())
			return _recipe;
	}
	
	return -1;
}