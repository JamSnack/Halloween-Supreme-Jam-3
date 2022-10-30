/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (global.game_stage < 35)
	instance_create_layer(x, y, "Instances", choose(entity_zombie, entity_zombie, entity_zombie, entity_zombie, entity_imp, entity_ghost));
else instance_create_layer(x, y, "Instances", choose(entity_zombie, entity_imp, entity_ghost));