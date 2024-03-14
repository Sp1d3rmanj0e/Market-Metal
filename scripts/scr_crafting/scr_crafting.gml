
/// @desc Resets the focus for all recipes except for the specified recipe
function change_recipe_focus(_recipeID) {
	
	// Reset all focuses for ALL recipes
	for (var i = 0; i < ds_list_size(global.crafting_recipes); i++) {
		var _recipe = ds_list_find_value(global.crafting_recipes, i);
		
		_recipe.reset_focus();
	}
	
	// Focus the specified recipe
	_recipe.set_focus();
}

function draw_all_recipes(_startX, _startY, _boxWidth, _boxHeight, _recipeWidth, _recipeHeight, _recipesPerRow) {
	
	// Calculate buffer based on space given and number of recipes per row
	// NOTE: There will always be a buffer at the start and at the end of each row
	//		 and a buffer in between recipes
	var _amountOfBufferToOffer = _boxWidth - _recipeWidth*_recipesPerRow;
	var _buffer = _amountOfBufferToOffer / (_recipesPerRow+1);
	
	if (_amountOfBufferToOffer < 0) {
		log("ERROR: scr_crafting - Amount of space needed to draw recipes exceeds space given!");
		return false;
	}
	
	// Vars to store where to draw recipes
	var _drawX = _startX + _buffer;
	var _drawY = _startY + _buffer;
	var _numberOfRecipesDrawnThisRow = 0;

	// Loops for all available recipes
	for (var i = 0; i < ds_list_size(global.crafting_recipes); i++) {
		var _recipe = ds_list_find_value(global.crafting_recipes, i);
		
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
	}
}