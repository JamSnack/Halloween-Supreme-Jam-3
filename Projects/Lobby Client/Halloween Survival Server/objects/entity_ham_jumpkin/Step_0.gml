/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
if (instance_exists(entity_player))
{
	if (distance_to_object(instance_nearest(x, y, entity_player)) > 500)
		instance_destroy();
}
event_inherited();