/// @description Insert description here
// You can write your code in this editor
event_inherited();

show_debug_message("Player Created");

//Entity variables
p_id = 0;

interpolation_rate = 0.5; //We want the player's position to be pretty accurate but still interpolate a bit
despawn_timer = -1; //never despawn

// - animation
walk_sprite = spr_player_walk;
run_sprite = spr_player_run;
idle_sprite = spr_player_idle;

// - colors
function cosmetic_controller() constructor
{
	shirt = {
		red : 0,
		green : 0,
		blue : 0
	};
	
	pants = {
		red : 0,
		green : 0,
		blue : 0
	};
	
	skin = {
		red : 0,
		green : 0,
		blue : 0
	};
	
	static set_colors = function (src_shirt, src_pants, src_skin)
	{
		if (src_shirt != undefined)
		{
			shirt.red = src_shirt.red;
			shirt.green = src_shirt.green;
			shirt.blue = src_shirt.blue;
		}
		
		if (src_pants != undefined)
		{
			pants.red = src_pants.red;
			pants.green = src_pants.green;
			pants.blue = src_pants.blue;
		}
		
		if (src_skin != undefined)
		{
			skin.red = src_skin.red;
			skin.green = src_skin.green;
			skin.blue = src_skin.blue;
		}
	}
}

player_cosmetics = new cosmetic_controller();

var _c = {
	red : 0,
	green : 0,
	blue : 0
}

var _s = {
	red : 255,
	green : 0,
	blue : 0
}

player_cosmetics.set_colors(_c, _c, _s);

