/// @description
p_id = 0; //which player owns this object; pass player_id into this object on instantiation.
p_n = ""; //The playername of this object
moved = false; //If the player's position has changed since the last heartbeat
dead = false; //whether or not this player is dead
max_hp = 10;
hp = max_hp;

death_timer_reset = room_speed*600;
death_timer = death_timer_reset;

player_inventory = array_create(global.inventory_size, 0);

candy_array = array_create(CANDY.last, 0);
has_candy = false;

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
		with ( entity_player )
		{
			if (dead == false)
				break;
			else
			{
				//reset/go to intermission
				global.game_stage = 1;
				
				//cleanup
				with (entity_enemy)
					instance_destroy();
					
				with (entity_block)
					instance_destroy();
					
				//Reset stats
				max_hp = 10;
			}
		}
		
		//set hp to max_hp
		hp = max_hp;
	}
		
	//send results
	var _d = ds_map_create();
	_d[? "cmd"] = "player_hp";
	_d[? "hp"] = hp;
	_d[? "mhp"] = max_hp;
	_d[? "p_id"] = p_id;
	send_data(_d);
}