/// @description 
event_inherited();

//Send new position to server
var key_left = keyboard_check(vk_left);
var key_right = keyboard_check(vk_right);
var key_up = keyboard_check(vk_up);
var key_down = keyboard_check(vk_down);

hmove = (key_right - key_left);
vmove = (key_down - key_up);

var moving = (hmove != 0 || vmove != 0);

//move
var walkspeed = 1;


if (key_left)
	x -= walkspeed;
	
if (key_right)
	x += walkspeed;
	
if (key_down)
	y += walkspeed;

if (key_up)
	y -= walkspeed;

if (moving)
{
	var _d = ds_map_create();
	_d[? "cmd"] = "player_move";
	_d[? "p_id"] = global.player_id;
	_d[? "h"] = hmove;
	_d[? "v"] = vmove;
	send_data(_d);
}

