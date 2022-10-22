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

//- Health
max_hp = 10;
hp = max_hp;

shoot_delay = 0;
action_state = "SHOOT";

//- Selected Block
selected_block = 0;

//- effects


