/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if (projectile_delay <= 0)
{
	var _speed = 2;
	var _r = choose(1, 2, 3);
	
	if (_r == 1)
	{
		scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 30), y + lengthdir_y(2, 30), _speed, entity_enemy_projectile_egg);
		scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 120), y + lengthdir_y(2, 120), _speed, entity_enemy_projectile_egg);
		scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 210), y + lengthdir_y(2, 210), _speed, entity_enemy_projectile_egg);
		scr_create_enemy_projectile(x, y, x+2, y, 3, entity_enemy_projectile_egg);
	}
	else if (_r == 2)
	{
		scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 60), y + lengthdir_y(2, 60), _speed, entity_enemy_projectile_egg);
		scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 150), y + lengthdir_y(2, 150), _speed, entity_enemy_projectile_egg);
		scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 240), y + lengthdir_y(2, 240), _speed, entity_enemy_projectile_egg);
		scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 300), y + lengthdir_y(2, 300), _speed, entity_enemy_projectile_egg);
	}
	else
	{
		scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 90), y + lengthdir_y(2, 90), _speed, entity_enemy_projectile_egg);
		scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 180), y + lengthdir_y(2, 180), _speed, entity_enemy_projectile_egg);
		scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 270), y + lengthdir_y(2, 270), _speed, entity_enemy_projectile_egg);
		scr_create_enemy_projectile(x, y, x + lengthdir_x(2, 330), y + lengthdir_y(2, 330), _speed, entity_enemy_projectile_egg);	
	}
	
	projectile_delay = room_speed*4;
}
else projectile_delay--;