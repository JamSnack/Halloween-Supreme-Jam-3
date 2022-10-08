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
			
			mp_linear_step(_nearest.x, _nearest.y, move_speed, false);
			moved = true;
		}
	}
	break;
}

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
	move_delay = 20;
}
else move_delay--;