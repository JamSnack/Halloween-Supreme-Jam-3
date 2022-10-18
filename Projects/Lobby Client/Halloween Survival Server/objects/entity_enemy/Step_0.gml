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
			
			var x_dir = sign(_nearest.x - x + 1) * move_speed;
			var y_dir = sign(_nearest.y - y + 1) * move_speed;
			
			x_speed = approach(x_speed, x_dir, torque);
			y_speed = approach(y_speed, y_dir, torque);
			
			//horizontal movement
			if (collision_rectangle(bbox_left + x_speed, bbox_top, bbox_right + x_speed, bbox_bottom, entity_block, false, true))
			{
				x_speed = -x_speed*bounce_factor;
			}
			
			x += x_speed;
			
			
			
			//vertical movement
			if (collision_rectangle(bbox_left, bbox_top + y_speed, bbox_right, bbox_bottom + y_speed, entity_block, false, true))
			{
				y_speed = -y_speed*bounce_factor;
			}
			
			y += y_speed;
			
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