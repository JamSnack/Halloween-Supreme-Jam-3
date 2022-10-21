/// @description

//If a player enters the boundary
if (instance_exists(entity_player))
{
	for (var i = 0; i < instance_number(entity_player); i++)
	{
		var _p = instance_find(entity_player, i);
		
		if (distance_to_point(_p.x, _p.y) <= range)
		{
			//grab candy and reward XPs
			if (_p.has_candy)
			{
				//loop through candy & deposit it
				for (var j = 0; j < CANDY.last; j++)
				{
					if (_p.candy_array[j] > 0)
					{
						candies_stored[j] += _p.candy_array[j];

						//send effect
						var _d = ds_map_create();
						_d[? "cmd"] = "effect_player_candy_to_core";
						_d[? "x"] = _p.x;
						_d[? "y"] = _p.y;
						_d[? "amt"] = ceil(_p.candy_array[j]/2);
						_d[? "t"] = j;
						send_data(_d);
					
						//send new candies
						networking_update_core_candies_at_index(j);
					
						//reset
						_p.candy_array[j] = 0;
					}
				}
				
				//reset
				_p.has_candy = false;
			}
		}
	}
}

//Convert candies into blocks
/*if (block_production <= 0)
{
	block_production = block_production_time;
	
	//add to blocks
	if (candies_stored[CANDY.yellow] > 0)
	{
		candies_stored[CANDY.yellow] -= 1;
		builds_stored[BUILD.block] += 1;
		networking_update_core_candies_at_index(CANDY.yellow);
		networking_update_core_builds_at_index(BUILD.block);
	}
	
	//doors
	if (candies_stored[CANDY.magenta] > 0)
	{
		candies_stored[CANDY.magenta] -= 1;
		builds_stored[BUILD.door] += 1;
		networking_update_core_candies_at_index(CANDY.magenta);
		networking_update_core_builds_at_index(BUILD.door);
	}
	
	//glass
	if (candies_stored[CANDY.teal] > 0)
	{
		candies_stored[CANDY.teal] -= 1;
		builds_stored[BUILD.glass] += 1;
		networking_update_core_candies_at_index(CANDY.teal);
		networking_update_core_builds_at_index(BUILD.glass);
	}
}
else block_production--;*/