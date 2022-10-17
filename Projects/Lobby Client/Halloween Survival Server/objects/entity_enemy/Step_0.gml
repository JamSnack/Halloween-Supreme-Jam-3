/// @description 

//Check for death
if (hp <= 0)
	instance_destroy();
	
//Movement step
switch (targeting_type)
{
	case TARGET_TYPE.normal:
	{
		//Mindlessly pursue the nearest player
		if (instance_exists(entity_player))
		{
			var _nearest = instance_nearest(x, y, entity_player);
			
			//var _dist = distance_to_object(_nearest);
			
			mp_linear_step_object(_nearest.x, _nearest.y, move_speed, entity_block);
			moved = true;
		}
	}
	break;
}

//Damage things
//- blocks
if (can_attack_block <= 0 && instance_exists(entity_block))
{
	var nearest_block = instance_nearest(x, y, entity_block);
	
	if (distance_to_object(nearest_block) < attack_range)
	{
		nearest_block.damage(block_damage);
		can_attack_block = room_speed*2;
	}
}
else if (can_attack_block > 0)
	can_attack_block--;

//- players
if (can_attack_player <= 0 && instance_exists(entity_player))
{
	var	nearest_player = instance_nearest(x, y, entity_player);
	
	if (distance_to_object(nearest_player) < attack_range)
	{
		nearest_player.damage(player_damage);
		can_attack_player = room_speed*2;
	}
}
else if (can_attack_player > 0)
	can_attack_player--;

//Send data
if (moved && move_delay <= 0)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "enemy_pos";
	_d[? "e_id"] = enemy_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	send_data(_d);
	
	moved = false;
	move_delay = 2;
}
else move_delay--;