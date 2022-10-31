/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (projectile_delay <= 0)
{
	if (instance_exists(entity_player))
	{
		var _p = instance_nearest(x, y, entity_player);	
		
		if (distance_to_object(_p) < 32*9)
		{
			scr_create_enemy_projectile(x, y, _p.x, _p.y, 10, entity_enemy_projectile_wind);
			
			projectile_delay = 30;
		}
	}
}
else projectile_delay--;
