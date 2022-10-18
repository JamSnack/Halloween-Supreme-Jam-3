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
			//if ( 
		}
	}
}