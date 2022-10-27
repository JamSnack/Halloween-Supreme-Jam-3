/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();


p_id = 0;
p_n = "";

interpolation_rate = 0.3;

walk_sprite = spr_player_walk;
run_sprite = spr_player_run;
idle_sprite = spr_player_idle;

skin_light = array_create(3, 2);
skin_dark = array_create(3, 12);
shirt_light = array_create(3, 2);
shirt_dark = array_create(3, 2);
pants_light = array_create(3, 2);
pants_dark = array_create(3, 2);

hp = 0;
max_hp = 10;
