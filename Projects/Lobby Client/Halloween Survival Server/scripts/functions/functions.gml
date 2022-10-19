function get_next_id()
{
	global.next_id += 1;
	
	if (global.next_id > 9999)
		global.next_id = 0;
	
	return global.next_id;
}

function approach(value, target, rate)
{
	if (argument0 < argument1)
	    return min(argument0 + argument2, argument1); 
	else
	    return max(argument0 - argument2, argument1);	
}

function scr_move_toward_point(target_x, target_y, move_speed)
{
	//Sets x_speed and y_speed of the instance
	var x_dir = sign(target_x - x + 1);
	var y_dir = sign(target_y - y + 1);
			
	x_speed = approach(x_speed, x_dir * move_speed, torque);
	y_speed = approach(y_speed, y_dir * move_speed, torque);
			
	//horizontal movement
	if (collision_rectangle(bbox_left + x_speed, bbox_top, bbox_right + x_speed, bbox_bottom, entity_block, false, true))
	{	
		repeat(10)
		{
			if (collision_rectangle(bbox_left + x_dir, bbox_top, bbox_right + x_dir, bbox_bottom, entity_block, false, true) == noone )
				x += x_dir;
			else break;
		}
				
		x_speed = -x_speed*bounce_factor;
	}
			
	x += x_speed;
			
			
			
	//vertical movement
	if (collision_rectangle(bbox_left, bbox_top + y_speed, bbox_right, bbox_bottom + y_speed, entity_block, false, true))
	{
		repeat(10)
		{
			if (collision_rectangle(bbox_left, bbox_top + y_dir, bbox_right, bbox_bottom + y_dir, entity_block, false, true) == noone )
				y += y_dir;
			else break;
		}
				
		y_speed = -y_speed*bounce_factor;
	}
			
	y += y_speed;
	
	//update object on client
	moved = true;
}