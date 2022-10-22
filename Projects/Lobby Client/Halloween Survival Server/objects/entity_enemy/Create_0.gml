/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

function send_enemy_to_client()
{
	var _d = ds_map_create();
	_d[? "cmd"] = "create_enemy";
	_d[? "e_id"] = enemy_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "mhp"] = max_hp;
	_d[? "hp"] = hp;
	_d[? "o_i"] = enemy_index; //what to create on the player's side
	send_data(_d);
}

function update_enemy()
{
	var _d = ds_map_create();
	_d[? "cmd"] = "enemy_update";
	_d[? "e_id"] = enemy_id;
	_d[? "hp"] = hp;
	send_data(_d);
}

function damage(amt, killer)
{
	hp -= amt;
	
	//death check
	if (hp <= 0)
	{
		killer.candy_array[held_treat] += held_treat_amt;
		killer.has_candy = true;
		killer.add_xp(max_hp);
		killer_id = killer.p_id;
		instance_destroy();
	}
	else update_enemy();
}

killer_id = -4;
move_delay = 2;
