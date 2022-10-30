/// @description
//client-side item stuff
/*
if (instance_exists(entity_item))
{
	var _nearest = instance_nearest(x, y, entity_item);
	
	if (distance_to_object(_nearest) < 16)
		with (_nearest)
		{
			//Send item data
			var _d = ds_map_create();
			_d[? "cmd"] = "item_pickup";
			_d[? "p_id"] = other.p_id;
			//_d[? "i_id"] = item_id;
			_d[? "index"] = image_index;
			send_data(_d);
			
			//Destroy item
			instance_destroy();
		}
}
*/

//boundaries
x = dead ? global.core_x : clamp(x, 0, WORLD_WIDTH);
y = dead ? global.core_y : clamp(y, 0, WORLD_HEIGHT);

//correct xscale
if (image_xscale == 0) image_xscale = 1;
if (image_yscale == 0) image_yscale = 1;

//regen
if (regen_delay <= 0 && hp < max_hp)
{
	damage(-1);
	regen_delay = room_speed*5;
}
else if (regen_delay > 0)
	regen_delay--;
	

if (moved)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "player_pos";
	_d[? "p_id"] = p_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "override"] = override_client_position;
	send_data(_d);
		
	override_client_position = false;
	moved = false;
}