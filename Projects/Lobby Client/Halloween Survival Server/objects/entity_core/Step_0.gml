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
					candies_stored[j] = _p.candy_array[j];
					_p.candy_array[j] = 0;
				}
				
				_p.has_candy = false;
			}
		}
	}
}

//Convert candies into blocks
if (block_production <= 0)
{
	block_production = block_production_time;
	
	//add to blocks
	if (candies_stored[CANDY.yellow] > 0)
	{
		candies_stored[CANDY.yellow] -= 1;
		builds_stored[BUILD.block] += 1;
	}
	
	//doors
	if (candies_stored[CANDY.magenta] > 0)
	{
		candies_stored[CANDY.magenta] -= 1;
		builds_stored[BUILD.door] += 1;
	}
	
	//glass
	if (candies_stored[CANDY.teal] > 0)
	{
		candies_stored[CANDY.teal] -= 1;
		builds_stored[BUILD.glass] += 1;
	}
}