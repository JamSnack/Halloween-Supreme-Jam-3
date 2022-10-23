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
			
			//update core revives
			var _d = ds_map_create();
			_d[? "cmd"] = "core_revives";
			_d[? "r"] = entity_core.player_revives;
			send_data(_d);
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

player_skills = array_create(STATS.last, 0);

stat_attack_damage = 0;
stat_movement_speed = 0;


//Init levelups
function update_stats()
{
	//Update stats
	var temp_heal = max_hp;
	max_hp = 10 + player_skills[STATS.hp];
	hp = max(hp, hp + max_hp-temp_heal);
		
	stat_attack_damage = player_skills[STATS.attack]/2;
	stat_movement_speed = player_skills[STATS.movespeed]*0.01;
	
	//Apply bonuses
	//- core bonus:
	if (instance_exists(entity_core))
	{
		//hp
		max_hp += STAT_HP;
		stat_attack_damage += STAT_ATTACK;
		stat_movement_speed += STAT_SPEED;
	}
	
	
}	


level = 0;
xp = 0;
xp_needed = 21;
skill_points = 0;

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
		skill_points++;
		
		//Add to stats
		update_stats();
		
		//level effects!
		_leveled = true;
		
		//reset
		xp_needed += xp_needed + ceil(xp_needed*0.33);
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
		_d[? "skps"] = skill_points;
		send_data(_d);
		
		//Update stats
		send_stats();
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

function send_stats()
{
	var _d = ds_map_create();
	_d[? "cmd"] = "update_stats";
	_d[? "p_id"] = p_id;
	_d[? "skps"] = skill_points;
	_d[? "mhp"] = max_hp;
	_d[? "hp"] = hp;
	
	//stats go into map
	for (var _i = 0; _i < STATS.last; _i++)
		_d[? string(_i)] = player_skills[_i];	
	
	send_data(_d);
	
	show_debug_message("sending stats");
}