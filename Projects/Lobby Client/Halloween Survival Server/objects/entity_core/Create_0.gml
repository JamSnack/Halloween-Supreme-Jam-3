/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//some stuff handled in variable definitions...

//Init core stuff
builds_stored = array_create(BUILD.last, 999);

//candies
candies_stored = array_create(CANDY.last, 0);

//stats
range = 128; //keeps track of players in range
block_production_time = 15*room_speed;
block_production = 0;