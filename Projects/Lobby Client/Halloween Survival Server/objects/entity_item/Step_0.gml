/// @description

//Fly toward the nearest player
if (instance_exists(entity_player))
{
	var _nearest = instance_nearest(x, y, entity_player);
	var _dist = distance_to_object(_nearest);
	
	if (_dist < 64)
	{
		x = lerp(x, _nearest.x, 0.2);
		y = lerp(y, _nearest.y, 0.2);
		moved = true;
	}
}



	//Send data
if (moved && move_delay <= 0)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "item_pos";
	_d[? "i_id"] = item_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	send_data(_d);
	
	moved = false;
	move_delay = 2;
}
else move_delay--;