/// @description
p_id = 0; //which player owns this object; pass player_id into this object on instantiation.
p_n = ""; //The playername of this object
moved = false; //If the player's position has changed since the last heartbeat
dead = false; //whether or not this player is dead

//death_timer_reset = room_speed*600;
//death_timer = death_timer_reset;

player_inventory = array_create(global.inventory_size, 0);

candy_array = array_create(CANDY.last, 0);
has_candy = false;

regen_delay = room_speed*10;

function damage(attack)
{
	//deal damage
	hp -= attack;
	
	//regen delay reset
	regen_delay = room_speed*20;
	
	//death check
	if (hp <= 0)
	{
		//death message
		scr_death_message(p_n);
		
		//Revive player or restart the round
		if (instance_exists(entity_core) && entity_core.player_revives > 0)
		{
			var _col = collision_point(CENTER_X - 32, CENTER_Y, entity_block, false, true);
			
			if (_col != noone)
				with (_col) instance_destroy();
			
			x = CENTER_X - 32;
			y = CENTER_Y;
			entity_core.player_revives -= 1;
			global.game_stage -= 1;
		}
		else
		{
			dead = true;
			x = 500;
			y = 2100;
		
			//Check to see if all players have died, ending the round
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


//Init stats
max_hp = 10;
hp = max_hp;

skill_hp = 0;
skill_attack = 0;
skill_speed = 0;

stat_attack_damage = 0;
stat_movement_speed = 0;


//Init levelups
function update_stats()
{
	if (instance_exists(entity_core))
	{
		var temp_heal = max_hp;
		max_hp = 10 + STAT_HP + skill_hp;
		hp = max(hp, hp + max_hp-temp_heal);
		
		stat_attack_damage = skill_attack + STAT_ATTACK;
		stat_movement_speed = skill_speed + STAT_SPEED;
	}
	else 
	{
		var temp_heal = max_hp;
		max_hp = 10 + skill_hp;
		hp = max(hp, hp + max_hp-temp_heal);
		
		stat_attack_damage = skill_attack;
		stat_movement_speed = skill_speed;
	}
	
	
}	


level = 0;
xp = 0;
xp_needed = 25;

function add_xp(amt)
{
	if (amt == undefined)
		return;
	
	var _leveled = false;
	
	//add to xp
	xp += amt;
	
	//check for level ups: level up and reset if necessary
	while (xp >= xp_needed)
	{
		xp -= xp_needed;
		level++;
		
		//Add to stats
		update_stats();
		
		//level effects!
		_leveled = true;
		
		//reset
		xp_needed += xp_needed;
	}
	
	//effects
	if (_leveled)
	{
		send_chat(p_n + " has reached level " + string(level) + "!");
		
		var _d = ds_map_create()
		_d[? "cmd"] = "level";
		_d[? "p_id"] = p_id;
		_d[? "l"] = level;
		_d[? "xp"] = xp;
		_d[? "xp_need"] = xp_needed;
		_d[? "x"] = x - 2;
		_d[? "y"] = y - 36;
		send_data(_d);
	}
	else
	{
		var _d = ds_map_create()
		_d[? "cmd"] = "xp";
		_d[? "p_id"] = p_id;
		_d[? "a"] = amt;
		_d[? "x"] = x - 2;
		_d[? "y"] = y - 36;
		send_data(_d);
	}
}