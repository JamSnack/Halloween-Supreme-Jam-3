/// @description 
event_inherited();

//Send new position to server
var key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var key_up = keyboard_check(vk_up) || keyboard_check(ord("W"));
var key_down = keyboard_check(vk_down) || keyboard_check(ord("S"));
var key_sprint = keyboard_check(vk_shift);

//Movement
hmove = (key_right - key_left);
vmove = (key_down - key_up);

var moving = (hmove != 0 || vmove != 0);

// - lock movement if chatting
if (global.chatting)
	moving = false;

// - send desired movement to server
if (moving)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "player_move";
	_d[? "p_id"] = global.player_id;
	_d[? "h"] = hmove;
	_d[? "v"] = vmove;
	_d[? "s"] = key_sprint;
	send_data(_d);
}

//client-side item stuff
if (instance_exists(obj_item_entity))
{
	var _nearest = instance_nearest(x, y, obj_item_entity);
	
	if (distance_to_object(_nearest) < 32)
		with (_nearest)
			instance_destroy();
}

