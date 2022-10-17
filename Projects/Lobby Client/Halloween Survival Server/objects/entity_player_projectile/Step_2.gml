/// @description
lifetime++;

if (instance_exists(entity_enemy))
{
	var nearest_enemy = instance_nearest(x, y, entity_enemy);

	if (distance_to_point(nearest_enemy.x, nearest_enemy.y) < 8)
	{
		with (nearest_enemy)
			nearest_enemy.damage(1);
			
		instance_destroy();
	}
}

if (lifetime > 3*room_speed || (instance_exists(entity_block) && collision_point(x, y, entity_block, false, true)) )
	instance_destroy();