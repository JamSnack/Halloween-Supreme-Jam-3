/// @description
if (lifetime == 0)
	networking_send_new_projectile(x, y, direction, speed, image_data, proj_id, friction);

lifetime++;

if (instance_exists(entity_player))
{
	var nearest_player = instance_nearest(x, y, entity_player);

	if (place_meeting(x, y, entity_player))
	{
		with (nearest_player)
			nearest_player.damage(1 + other.attack_damage);
			
		instance_destroy();
	}
}

var colliding_with_block = false;

if (instance_exists(entity_block))
{
	var col = collision_point(x, y, entity_block, false, true);
	
	if (col != noone)
	{
		col.damage(block_damage);
		instance_destroy();
	}
}

if (lifetime > 3*room_speed || colliding_with_block)
	instance_destroy();