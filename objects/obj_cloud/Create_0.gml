/// @description Insert description here
// You can write your code in this editor

randomize();

sprite_index = choose(spr_cloud1, spr_cloud2, spr_cloud3);

cloud_height = irandom_range(-10, 40);
cloud_depth = random_range(0.1, 0.8);

y = cloud_height;
image_xscale = cloud_depth;
image_yscale = cloud_depth;
image_alpha = cloud_depth;

cloud_speed = 0.5 * cloud_depth;

function get_sprite_based_on_time(_timeEnum) {
	switch(_timeEnum) {
		case BG.SUNRISE: return 2; break;
		case BG.DAY: return 0; break;
		case BG.SUNSET: return 3; break;
		case BG.NIGHT:
		case BG.AURORA: return 1; break;
		default: return 0;
	}
}