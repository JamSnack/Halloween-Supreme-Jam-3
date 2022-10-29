/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//Tender Spirit Spawns
if (tender_spirit_spawn_delay <= 0)
{
	if (instance_number(entity_skeleton_crab_minion) < 10)
	{
		repeat(3)
			instance_create_layer(x + irandom_range(-32, 32), y + irandom_range(-32, 32), "Instances", entity_skeleton_crab_minion);
		
		tender_spirit_spawn_delay = room_speed*60;
	}
}
else tender_spirit_spawn_delay--;

//Projectile Attack
if (projectile_shoot_delay <= 0)
{
	if (instance_exists(entity_player))
	{
		var _p = instance_nearest(x, y, entity_player);
		
		if (distance_to_object(_p) < 32*7)
		{
			scr_create_enemy_projectile(x, y, _p.x - 12, _p.y - 12, 6, entity_enemy_projectile_egg);
			scr_create_enemy_projectile(x, y, _p.x, _p.y, 6, entity_enemy_projectile_egg);
			scr_create_enemy_projectile(x, y, _p.x + 12, _p.y + 12, 6, entity_enemy_projectile_egg);
			
			projectile_shoot_delay = room_speed*3;
		}
	}
}
else projectile_shoot_delay--;

//Wave attack
if (projectile_shoot_delay2 <= 0)
{
	if (instance_exists(entity_player))
	{
		var _p = instance_nearest(x, y, entity_player);
		
		if (distance_to_object(_p) < 32*10)
		{
			var _speed = 2;
			
			scr_create_enemy_projectile(x, y, x+1, y, 3, entity_enemy_projectile_wave);
			scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 30), y + lengthdir_y(2, 30), _speed, entity_enemy_projectile_wave);
			scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 60), y + lengthdir_y(2, 60), _speed, entity_enemy_projectile_wave);
			scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 90), y + lengthdir_y(2, 90), _speed, entity_enemy_projectile_wave);
			
			scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 120), y + lengthdir_y(2, 120), _speed, entity_enemy_projectile_wave);
			scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 150), y + lengthdir_y(2, 150), _speed, entity_enemy_projectile_wave);
			scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 180), y + lengthdir_y(2, 180), _speed, entity_enemy_projectile_wave);
																										
			scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 210), y + lengthdir_y(2, 210), _speed, entity_enemy_projectile_wave);
			scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 240), y + lengthdir_y(2, 240), _speed, entity_enemy_projectile_wave);
			scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 270), y + lengthdir_y(2, 270), _speed, entity_enemy_projectile_wave);
																										
			scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 300), y + lengthdir_y(2, 300), _speed, entity_enemy_projectile_wave);
			scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 330), y + lengthdir_y(2, 330), _speed, entity_enemy_projectile_wave);
			
			
			projectile_shoot_delay2 = room_speed*3.5;
		}
	}
}
else projectile_shoot_delay2--;