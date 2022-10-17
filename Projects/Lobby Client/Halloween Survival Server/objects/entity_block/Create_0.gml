/// @description
max_hp = 10;
hp = max_hp;

tile_id = get_next_id();

function send_new_block_to_player()
{
	var _d = ds_map_create();
	_d[? "cmd"] = "tile_place";
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "hp"] = hp;
	_d[? "mhp"] = max_hp;
	_d[? "t_id"] = tile_id;
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
	hp -= amt;
	
	if (hp <= 0)
		instance_destroy();
	else
		update_block();
}