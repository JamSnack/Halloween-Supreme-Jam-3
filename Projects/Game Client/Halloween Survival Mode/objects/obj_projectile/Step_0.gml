/// @description Insert description here
// You can write your code in this editor
if (lag_timer <= 0)
{
	visible = true;
	lifetime++;

	//Collision
	//- block collision
	var colliding_with_block = false;

	if (instance_exists(obj_block_entity))
	{
		var col = collision_point(x, y, obj_block_entity, false, true);
	
		if (col != noone)
		{
			if (col.object_index != obj_block_glass_entity)
				colliding_with_block = true;
		}
	}

	//- enemy collision
	if (instance_exists(obj_enemy_entity))
	{
		if (place_meeting(x, y, obj_enemy_entity))
			colliding_with_block = true;
	}

	//Kill
	if (lifetime > room_speed - 10 || colliding_with_block)
		instance_destroy();
}
else
{
	lag_timer--;
	x -= hspeed;
	y -= vspeed;
	visible = false;
}