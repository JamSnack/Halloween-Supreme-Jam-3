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
x = clamp(x, 0, 999);
y = dead ? clamp(y, 3000, 3500) : clamp(y, 1000, 3000);

//correct xscale
if (image_xscale == 0) image_xscale = 1;
if (image_yscale == 0) image_yscale = 1;