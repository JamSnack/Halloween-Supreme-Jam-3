/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//Tender Spirit Spawns
if (tender_spirit_spawn_delay <= 0)
{
	if (!instance_exists(entity_tender_spirit))
	{
		repeat(6)
			 instance_create_layer(x + irandom_range(-32, 32), y + irandom_range(-32, 32), "Instances", entity_tender_spirit);
			 
		tender_spirit_spawn_delay = room_speed*60*5;
	}
}
else tender_spirit_spawn_delay--;

//Projectile Attack
if (projectile_shoot_delay <= 0)
{
	if (instance_exists(entity_player))
	{
		var _p = instance_nearest(x, y, entity_player);
		
		if (distance_to_object(_p) < 32*6)
		{
			scr_create_enemy_projectile(x, y, _p.x, _p.y, 6, entity_enemy_projectile_egg);
			scr_create_enemy_projectile(x + 20, y, _p.x, _p.y, 6, entity_enemy_projectile_egg);
			scr_create_enemy_projectile(x, y + 20, _p.x, _p.y, 6, entity_enemy_projectile_egg);
			
			projectile_shoot_delay = room_speed*3;
		}
	}
}
else projectile_shoot_delay--;

