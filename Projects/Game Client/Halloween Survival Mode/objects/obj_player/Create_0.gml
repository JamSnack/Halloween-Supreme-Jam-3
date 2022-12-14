/// @description Insert description here
// You can write your code in this editor
event_inherited();

show_debug_message("Player Created");

//Entity variables
p_id = 0;

interpolation_rate = 0.06; //We want the player's position to be pretty accurate but still interpolate a bit

// - animation
walk_sprite = spr_player_walk;
run_sprite = spr_player_run;
idle_sprite = spr_player_idle;

//- Health
max_hp = 10;
hp = max_hp;

// -- visuals
health_surface = 0;
health_jam_animation = 0;

shoot_delay = 0;
action_state = "SHOOT";

//- Selected Block
selected_block = 0;
animate_building = 0;

use_anim_index = false;
use_animation_prediction = false;