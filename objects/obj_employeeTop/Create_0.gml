/// @description Insert description here
// You can write your code in this editor

// Variables given before creation
// profession - PROF.enum
// is_outdoors - whether or not the bot is outdoors or not
// passenger_seat - the id of the seat they were assigned


// Store initial position upon creation for reference
event_inherited();

walk_speed = 5;

is_sitting = false;

command_queue = ds_list_create();

inventory_id = create_inventory(2);
show_inventory = false;

profile_ui_id = noone;

inventory = ds_list_create();

// Base stats
stat_speed		= random_probability_curve(1, 10);
stat_efficiency	= random_probability_curve(1, 10);
stat_metabolism	= random_probability_curve(1, 10);
stat_resilience	= random_probability_curve(1, 10);

#region Get Visual Traits
randomize();

// Assign Skin Tone
skin_tone_color = choose(#E9C7AE, #E1B397, #D2A383, #C29170, 
						 #C0796D, #BA7D69, #B77E61, #B27F5E, 
						 #AE805B, #AC8559, #A16F4E, #8E5E3E, 
						 #7A4F32, #623F27, #4B3320);

// Assign gender
gender = choose("male", "female");

// Get a hat sprite (includes hair)
hat = choose(noone, 
			 spr_blue_bb_cap, spr_green_bb_cap, spr_red_bb_cap,
			 spr_gray_beanie, spr_orange_beanie, spr_red_beanie,
			 spr_propeller_hat, 
			 spr_black_bucket_hat, spr_lime_bucket_hat, spr_tan_bucket_hat, 
			 spr_brown_millitary_hat, spr_green_millitary_hat, spr_tan_millitary_hat,
			 spr_blue_winter_hat, spr_red_winter_hat, spr_yellow_winter_hat,
			 spr_blonde_long_hair, spr_brown_long_hair, spr_dark_long_hair,
			 spr_blonde_medium_hair, spr_brown_medium_hair, spr_dark_medium_hair,
			 spr_blonde_short_hair, spr_brown_short_hair, spr_dark_short_hair,
			 spr_blonde_very_long_hair, spr_brown_very_long_hair, spr_dark_very_long_hair);
	
// Get a shirt sprite
shirt = noone;
if (gender == "female") {
	
	shirt = choose(spr_blue_heavy_coat_female, spr_grey_heavy_coat_female,
				   spr_long_sleeve_blue_shirt_female, spr_long_sleeve_BnW_shirt_female,
				   spr_long_sleeve_gray_shirt_female, spr_short_sleeve_brown_camo_female,
				   spr_short_sleeve_green_camo_female, spr_short_sleeve_tan_camo_female,
				   spr_short_sleeve_blue_flowers_female, spr_short_sleeve_yellow_flowers_female,
				   spr_short_sleeve_generic_black_female, spr_short_sleeve_generic_dark_blue_female,
				   spr_short_sleeve_generic_maroon_female);
	
} else {
	shirt = choose(spr_blue_heavy_coat_male, spr_grey_heavy_coat_male,
				   spr_long_sleeve_blue_shirt_male, spr_long_sleeve_BnW_shirt_male,
				   spr_long_sleeve_gray_shirt_male, spr_short_sleeve_brown_camo_male,
				   spr_short_sleeve_green_camo_male, spr_short_sleeve_tan_camo_male,
				   spr_short_sleeve_blue_flowers_male, spr_short_sleeve_yellow_flowers_male,
				   spr_short_sleeve_generic_black_male, spr_short_sleeve_generic_dark_blue_male,
				   spr_short_sleeve_generic_maroon_male);
				   
}


shoes = choose([spr_boot_brown_camo, spr_sit_boot_brown_camo], 
			   [spr_boot_green_camo, spr_sit_boot_green_camo], 
			   [spr_boot_tan_camo, spr_sit_boot_tan_camo],
			   [spr_black_dress_shoe, spr_sit_black_dress_shoe], 
			   [spr_brown_dress_shoe, spr_sit_brown_dress_shoe],
			   [spr_blue_slippers, spr_sit_blue_slippers], 
			   [spr_green_slippers, spr_sit_green_slippers], 
			   [spr_pink_slippers, spr_sit_pink_slippers],
			   [spr_blue_tennis_shoes, spr_sit_blue_tennis_shoes], 
			   [spr_red_tennis_shoes, spr_sit_red_tennis_shoes], 
			   [spr_white_tennis_shoes, spr_sit_white_tennis_shoes]);

#endregion Get Visual Traits

#region Draw Visual Trait Functions

// Returns the correct sit sprite based on gender
function get_sit_sprite(_gender = gender) {
	if (_gender == "male") return spr_passengerFlatSit;
	else return spr_passengerCurvySit;
}

// Returns the correct walk sprite based on gender
function get_walk_sprite(_gender = gender) {
	if (_gender == "male") return spr_passengerFlatWalk;
	else return spr_passengerCurvyWalk;
}

// Returns the correct use sprite based on gender
function get_use_sprite(_gender = gender) {
	if (_gender == "male") return spr_passengerFlatUse;
	else return spr_passengerCurvyUse;
}

function draw_hat(_spriteIndex = hat) {
	
	if (_spriteIndex == noone) {return;}
	
	var _x, _y;
	
	if (!is_sitting) {
		
		// We add origin offsets because the 
		// person and clothing are off by 3 pixels (while walking)
		_x = x + (3 * image_xscale);
		_y = y + 3;
		
	} else {
		
		_x = x;
		_y = y + 14;
		image_index = 1;
	}
	
	draw_sprite_ext(_spriteIndex, image_index, 
					_x, _y, image_xscale, 1, 0, c_white, 1);
}

function draw_shirt(_spriteIndex = shirt) {
	
	var _x, _y;
	
	if (!is_sitting) {
		
		// We add origin offsets because the 
		// person and clothing are off by 3 pixels (while walking)
		_x = x + (3 * image_xscale);
		_y = y + 3;
		
	} else {
		
		_x = x;
		_y = y + 14;
		image_index = 1;
	}
	
	draw_sprite_ext(_spriteIndex, image_index, 
					_x, _y, image_xscale, 1, 0, c_white, 1);
}

/// @desc draws the shoes of the player in sitting and moving positions
/// @param _spriteIndex - [walkingSprite, sittingSprite]
function draw_shoes(_spriteIndex = shoes) {
	
	var _x, _y, _shoeSprite;
	
	if (!is_sitting) {
		
		_shoeSprite = _spriteIndex[0];
		
		// We add origin offsets because the 
		// person and clothing are off by 3 pixels (while walking)
		_x = x + (3 * image_xscale);
		_y = y + 3;
		
	} else {
		
		_shoeSprite = _spriteIndex[1];
		
		_x = x + (13 * image_xscale);
		_y = y + 2;
	}
	
	draw_sprite_ext(_shoeSprite, image_index, 
					_x, _y, image_xscale, 1, 0, c_white, 1);
	
}

#endregion Draw Visual Trait Functions

function add_item_to_inventory(_id) {
	
	inventory_add_item_next_slot(inventory_id, _id);
	
}