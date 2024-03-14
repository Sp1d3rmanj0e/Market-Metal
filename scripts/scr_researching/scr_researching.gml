global.researched_items = [];
global.researchable_recipes = ds_list_create();
global.recipes_that_need_confirmation = ds_list_create();
global.crafting_recipes = ds_list_create();
global.research_inventory = create_inventory(1);

function load_recipes_into_game() {
	create_recipe(ITEM.WEAPONS, [ITEM.WOOD, ITEM.IRON], 
		[[ITEM.FOLIAGE, ITEM.NONE, ITEM.NONE],
		 [ITEM.NONE, ITEM.FOLIAGE, ITEM.NONE],
		 [ITEM.NONE, ITEM.NONE, ITEM.NONE],
	     [ITEM.NONE, ITEM.NONE, ITEM.NONE]]);
	create_recipe(ITEM.PLEXIGLASS, [ITEM.GLASS, ITEM.DIAMOND], 
		[[ITEM.NONE, ITEM.NONE, ITEM.NONE],
		 [ITEM.NONE, ITEM.NONE, ITEM.NONE],
		 [ITEM.NONE, ITEM.NONE, ITEM.NONE],
	     [ITEM.NONE, ITEM.NONE, ITEM.NONE]]);
	create_recipe(ITEM.ARROWS, [ITEM.FEATHERS, ITEM.WOOD], 
		[[ITEM.NONE, ITEM.NONE, ITEM.NONE],
		 [ITEM.NONE, ITEM.NONE, ITEM.NONE],
		 [ITEM.NONE, ITEM.NONE, ITEM.NONE],
	     [ITEM.NONE, ITEM.NONE, ITEM.NONE]]);
	create_recipe(ITEM.STONE, [ITEM.WOOD], 
		[[ITEM.NONE, ITEM.NONE, ITEM.NONE],
		 [ITEM.NONE, ITEM.IRON, ITEM.NONE],
		 [ITEM.NONE, ITEM.NONE, ITEM.NONE],
	     [ITEM.NONE, ITEM.NONE, ITEM.NONE]]);
	create_recipe(ITEM.STONE, [ITEM.WOOD], 
		[[ITEM.NONE, ITEM.NONE, ITEM.NONE],
		 [ITEM.NONE, ITEM.NONE, ITEM.NONE],
		 [ITEM.NONE, ITEM.NONE, ITEM.NONE],
	     [ITEM.NONE, ITEM.NONE, ITEM.NONE]]);
	create_recipe(ITEM.STONE, [ITEM.WOOD, ITEM.IRON], 
		[[ITEM.NONE, ITEM.NONE, ITEM.NONE],
		 [ITEM.NONE, ITEM.NONE, ITEM.NONE],
		 [ITEM.NONE, ITEM.NONE, ITEM.NONE],
	     [ITEM.NONE, ITEM.NONE, ITEM.NONE]]);
	create_recipe(ITEM.STONE, [ITEM.WOOD, ITEM.IRON], 
		[[ITEM.NONE, ITEM.NONE, ITEM.NONE],
		 [ITEM.NONE, ITEM.NONE, ITEM.NONE],
		 [ITEM.NONE, ITEM.NONE, ITEM.NONE],
	     [ITEM.NONE, ITEM.NONE, ITEM.NONE]]);
}

function create_recipe(_item, _itemRequirements, _recipe) {
	ds_list_add(global.researchable_recipes, new item_recipe(_item, _itemRequirements, _recipe));
}

/// @description - a constructor of a recipe that contains all the information 
///				   to unlock and craft the item
/// @param _item - the item enum that can be crafted as a result of this recipe
/// @param _itemRequirements - an array of item enums that must all be researched
///							   before the recipe becomes unlocked
/// @param _recipe - a 2d array consisting of 4 rows and 3 columns, containing the 
///					 items in their respective slots on how to craft the given item
///					 organized like so [row][column]
function item_recipe(_item, _itemRequirements, _recipe) constructor {
	
	item_to_craft  = _item;
	item_reqs = _itemRequirements;
	recipe = _recipe;
	
	num_items_needed_to_unlock = array_length(item_reqs);
	
	focus = false;
	selected = false;
	unlockable = false;
	
	// Variables that get updated after every draw step
	// (used for collisions)
	x = 0;
	y = 0;
	width = 0;
	height = 0;
	
	static get_item = function() {
		return item_to_craft;
	}
	
	static get_requirements = function() {
		return item_reqs;
	}
	
	static get_recipe = function() {
		return recipe;
	}
	
	static is_unlockable = function() {
		return unlockable;
	}
	
	static set_focus = function() {
		focus = true;
	}
	
	static reset_focus = function() {
		focus = false;
	}
	
	static get_focus = function() {
		return focus;
	}
	
	static set_selected = function() {
		selected = true;
		focus = false;
	}
	
	static reset_selected = function() {
		selected = false;
	}
	
	static get_selected = function() {
		return selected;
	}
	
	static draw = function(_x, _y, _width, _height) {
		
		// Update these variables when being drawn
		// for collision purposes
		x = _x;
		y = _y;
		width = _width;
		height = _height;
		
		// Draw the recipe
		draw_set_color(c_white);
		
		// Draw the sprite with the backdrop
		draw_rectangle(_x, _y, _x + _width, _y + _height, false);
		draw_sprite_stretched(get_item_data_from_enum(item_to_craft, "sprite"), 0, _x, _y, _width, _height);
		draw_set_color(-1);
		
		// Check to see if the recipe should be focused
		if (!focus) {
			if (point_in_rectangle(mouse_x, mouse_y, _x, _y, _x + _width, _y + _width)
			and mouse_check_button_pressed(mb_left)) {
				set_focus();
				mouse_clear(mb_left);
			}
			
		// Check to see if the recipe should be unfocused
		} else if (mouse_check_button_released(mb_left)) { 
			reset_focus();
		}
	}
	
	/// @description - this function is called any time a new item is researched.  If
	///				   the newly researched item was a research requirement for this
	///				   recipe, then it will reduce the number of items required to unlock
	///				   by 1.  When there are no more items required to unlock, it will set
	///				   itself to unlockable.
	/// @param _itemEnum - the item that was recently researched
	static new_item_researched = function(_itemEnum) {
		
		// Check to see if item is needed to unlock the recipe
		if (array_find_index(item_reqs, _itemEnum) != -1) {
			
			// If so, reduce the number of items needed to unlock this recipe by 1
			num_items_needed_to_unlock--;
		}
		
		// If the list is now empty, set itself to unlockable
		if (num_items_needed_to_unlock <= 0)
			unlockable = true;
	}
}

/// @description - returns the index of an item within an array
/// @param _array - the array to check for the item
/// @param _item - the item to check for within the array
/// @returns - array index number, if the item does not exist within the array, it will return -1
function array_find_index(_array, _item) {
	
	// Go through every item in the array
	for (var i = 0; i < array_length(_array); i++) {
		
		// Compare an item in the array to the target item
		var _element = _array[i];
		
		if (_element == _item)
			return i;
	}
	
	return -1;
}

/// @description - tells the program whether a given item has been researched or not
/// @param _itemEnum - the item enum to check if has been researched or not
/// @returns - boolean - true if the item has been researched, false if not
function item_already_researched(_itemEnum) {
	
	// Loop through every item in the researched items array
	for (var i = 0; i < array_length(global.researched_items); i++) {
		var _item = global.researched_items[i];
		
		// If the item is found in the array, return true
		if (_item = _itemEnum)
			return true;
	}
	
	// Otherwise return false
	return false;
}

/// @description - adds an item to the researched_items array, updates all recipes about the
///				   new research addition, then adds all recipes that were just unlocked by the
///				   new item into the recipes_that_need_confirmation list.
/// @param _itemEnum - the item enum to add to the recipe list
function research_item(_itemEnum) {
	
	log("researching item");
	
	// Check to see if the item already is researched
	if (!item_already_researched(_itemEnum)) {
	
		array_push(global.researched_items, _itemEnum);
	
		// Update all of the recipes with the new item researched
		// and move all fully researched recipes into the recipes_that_need_confirmation array
	
		// Loop through the list of recipes that aren't yet complete
		for (var i = 0; i < ds_list_size(global.researchable_recipes); i++) {
			var _recipe = ds_list_find_value(global.researchable_recipes, i);
		
			// Tell the recipe that a new item got researched
			_recipe.new_item_researched(_itemEnum);
			
			log("Told recipe: " + string(_recipe) + " of the new research!");
			
			// Check to see if the recipe is now complete.  If so, move it
			// to the recipes_that_need_confirmation array
			if (_recipe.is_unlockable()) {
				
				log("recipe is unlockable!");
				
				// Remove the recipe from the old ds_list
				var _index = ds_list_find_index(global.researchable_recipes, _recipe);
				ds_list_delete(global.researchable_recipes, _index);
				i--;
			
				// Add the recipe to the new ds_list
				ds_list_add(global.recipes_that_need_confirmation, _recipe);
			}
		}
	} else {
		show_debug_message("Item already researched");
	}
}