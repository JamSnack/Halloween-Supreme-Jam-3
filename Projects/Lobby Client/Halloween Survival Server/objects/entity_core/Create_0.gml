/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//some stuff handled in variable definitions...

//Init core stuff
//builds_stored = array_create(BUILD.last, 0);

//candies
candies_stored = array_create(CANDY.last, 0);

//stats
range = 128; //keeps track of players in range
//block_production_time = 1*room_speed;
//block_production = block_production_time;

player_revives = 12;

//Regen
base_regen_delay = room_speed*2;
tile_seeing = 0;