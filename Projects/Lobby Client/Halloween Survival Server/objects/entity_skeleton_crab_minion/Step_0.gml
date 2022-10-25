/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//attacks
if (projectile_attack_delay <= 0)
{
	if (instance_exists(entity_player))
	{
		var _p = instance_nearest(x, y, entity_player);
		
		if (distance_to_object(_p) < 32*6)
		{
			scr_create_enemy_projectile(x, y, _p.x, _p.y, 6, entity_enemy_projectile_egg);
			
			projectile_attack_delay = room_speed*3;
		}
	}
}
else projectile_attack_delay--;

