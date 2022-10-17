/// @description Insert description here
// You can write your code in this editor
function send_item_to_client()
{
	var _d = ds_map_create();
	_d[? "cmd"] = "create_item";
	_d[? "i_id"] = item_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	_d[? "index"] = image_index;
	send_data(_d);
}

send_item_to_client();

move_delay = 2;
moved = false;

// Inherit the parent event
event_inherited();

