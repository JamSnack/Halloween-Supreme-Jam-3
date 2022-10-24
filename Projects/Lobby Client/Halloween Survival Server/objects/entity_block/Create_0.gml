/// @description
function send_new_block_to_player()
{
	var _d = ds_map_create();
	_d[? "cmd"] = "tile_place";
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "hp"] = hp;
	_d[? "mhp"] = max_hp;
	_d[? "t_id"] = tile_id;
	_d[? "type"] = type;
	send_data(_d);
}

send_new_block_to_player();

function update_block()
{
	var _d = ds_map_create();
	_d[? "cmd"] = "tile_update";
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "hp"] = hp;
	send_data(_d);
}

function damage(amt)
{
	//remove hp
	hp -= amt;
	
	if (hp <= 0)
		instance_destroy();
	else
		update_block();
		
	//halt spawn regen
	regen_hp = false;
	
	//effects
	if (amt > -1)
		send_damage(x + random_range(-26, 26), y + random_range(-26, 26), amt);
}

//Initial placement
regen_hp = true;
update_block_during_regen_delay = 60;