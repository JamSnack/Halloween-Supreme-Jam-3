/// @description
lifetime++;

if (instance_exists(entity_enemy))
{
	var nearest_enemy = instance_nearest(x, y, entity_enemy);

	if (distance_to_point(nearest_enemy.x, nearest_enemy.y) < 8)
	{
		var _stat_attack = (instance_exists(entity_core) ? STAT_ATTACK : 0);
		
		with (nearest_enemy)
			nearest_enemy.damage(1 + _stat_attack, other.parent_player);
			
		instance_destroy();
	}
}

var colliding_with_block = false;

if (instance_exists(entity_block))
{
	var col = collision_point(x, y, entity_block, false, true);
	
	if (col != noone)
	{
		if (col.object_index != entity_block_glass)
			colliding_with_block = true;
	}
}

if (lifetime > 3*room_speed || colliding_with_block)
	instance_destroy();