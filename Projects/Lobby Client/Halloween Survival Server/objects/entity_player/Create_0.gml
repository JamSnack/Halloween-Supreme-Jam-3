/// @description
p_id = 0; //which player owns this object; pass player_id into this object on instantiation.
p_n = ""; //The playername of this object
moved = false; //If the player's position has changed since the last heartbeat
dead = false; //whether or not this player is dead
max_hp = 1;
hp = max_hp;
knockback = true;

death_timer_reset = room_speed*600;
death_timer = death_timer_reset;

player_inventory = array_create(global.inventory_size, 0);

function damage(attack)
{
	//deal damage
	hp -= attack;
	
	//death check
	if (hp <= 0)
	{
		dead = true;
		x = 500;
		y = 3100;
		
		//Check to see if all players have died
		for (var i = 0; i < instance_count; i++) 
		{
			with ( instance_find(entity_player, i) )
			{
				if (dead == false)
					break;
				else
				{
					global.game_stage = 1;
				
					//cleanup
					with (entity_enemy)
						instance_destroy();
					
					with (entity_block)
						instance_destroy();
				}
			}
		}
	}
		
	//send results
}