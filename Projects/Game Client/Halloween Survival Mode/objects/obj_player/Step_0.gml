/// @description 
event_inherited();

//Send new position to server
var key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var key_up = keyboard_check(vk_up) || keyboard_check(ord("W"));
var key_down = keyboard_check(vk_down) || keyboard_check(ord("S"));
var mouse_left = mouse_check_button(mb_left);
var key_sprint = !mouse_left;

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
	sprite_index = run_sprite;
	
	//new, drawn position
	var _stat_speed = instance_exists(obj_core) ? STAT_SPEED : 0;
	_stat_speed += gameControl.player_stats[STATS.movespeed]*0.33;

	var x_speed = (1.5 + key_sprint*1.5 + _stat_speed)*hmove;
	var y_speed = (1.5 + key_sprint*1.5 + _stat_speed)*vmove;
						
	//check for collision, setting speed to 0 if colliding
	if (instance_exists(obj_block_entity))
	{
		//find collisions -> init vars
		var h_collision = collision_rectangle(bbox_left + x_speed, bbox_top, bbox_right + x_speed, bbox_bottom, obj_block_entity, false, true);
		var v_collision = collision_rectangle(bbox_left, bbox_top + y_speed, bbox_right, bbox_bottom + y_speed, obj_block_entity, false, true);
							
		//horizontal collision
		if (h_collision != noone && h_collision.object_index != obj_block_door_entity)
			x_speed = 0;
							
		//vertical collision
		if (v_collision != noone && v_collision.object_index != obj_block_door_entity)
			y_speed = 0;
	}
						
						
	//apply speed to movement
	x += x_speed;
	y += y_speed;
	draw_x = x;
	draw_y = y;
	
	//send requested position
	var _d = ds_map_create();
	_d[? "cmd"] = "player_move";
	_d[? "p_id"] = global.player_id;
	_d[? "x"] = x;
	_d[? "y"] = y;
	//_d[? "s"] = key_sprint;
	send_data(_d);
	
	if (hmove != 0)
		image_xscale = hmove;
}
else
{
	sprite_index = idle_sprite;	
}


//clamp to world
x = clamp(x, 0, WORLD_WIDTH);
y = clamp(y, 0, WORLD_HEIGHT);

//client-side item stuff
/*
if (instance_exists(obj_item_entity))
{
	var _nearest = instance_nearest(x, y, obj_item_entity);
	
	if (distance_to_object(_nearest) < 32)
		with (_nearest)
			instance_destroy();
}
*/

//shooting gun
var _stats_attack_speed = instance_exists(obj_core) ? gameControl.player_stats[STATS.attack_speed]*2 + STAT_ATTACK_SPEED : gameControl.player_stats[STATS.attack_speed]*2;

if (mouse_left && shoot_delay <= (_stats_attack_speed) && !global.chatting && gameControl.draw_character_sheet == 0)
{
	switch (action_state)
	{
		case "SHOOT":
		{
			//send packet
			var _dir = point_direction(x, y, mouse_x, mouse_y);
	
			var _d = ds_map_create();
			_d[? "cmd"] = "request_shoot";
			_d[? "x"] = x;
			_d[? "y"] = y;
			_d[? "dir"] = _dir;
			_d[? "p_id"] = global.player_id;
			send_data(_d);
	
			//shoot delay
			shoot_delay = 22;
	
			//client effects
			/*
			var stat_proj_speed = (instance_exists(obj_core)) ? STAT_PROJ_SPEED : 0;
			
			var _s = instance_create_layer(x, y, "Instances", obj_projectile);
			_s.direction = _dir;
			_s.speed = 5 + stat_proj_speed;
			_s.image_angle = _dir;
			_s.lag_timer = gameControl.ping;
			*/
		
		}
		break;
		
		case "BUILD":
		{
			//request build
			var _d = ds_map_create();
			_d[? "cmd"] = "request_tile_place";
			_d[? "x"] = MOUSE_X_IN_WORLD;
			_d[? "y"] = MOUSE_Y_IN_WORLD;
			_d[? "type"] = selected_block;
			send_data(_d);
		}
		break;
	}
}
else if (shoot_delay > 0)
	shoot_delay--;

//- swap action state
if ( keyboard_check_released(ord("F")) )
{
	switch (action_state)
	{
		case "SHOOT": { action_state = "BUILD"; } break;
		case "BUILD": { action_state = "SHOOT"; } break;
	}
}

//Remove block
if (mouse_check_button_pressed(mb_right))
{
	//request build
	var _d = ds_map_create();
	_d[? "cmd"] = "request_tile_destroy";
	_d[? "x"] = MOUSE_X_IN_WORLD;
	_d[? "y"] = MOUSE_Y_IN_WORLD;
	send_data(_d);
}

//Select block
var key_block = (keyboard_check_released(ord("Z")) || keyboard_check_released(vk_numpad1));
var key_door = (keyboard_check_released(ord("X")) || keyboard_check_released(vk_numpad2));
var key_glass = (keyboard_check_released(ord("C")) || keyboard_check_released(vk_numpad3));

if (key_block || key_door || key_glass)
{
	//switch action state
	action_state = "BUILD";
	
	//select block
	if (key_block)
		selected_block = 0;
	else if (key_door)
		selected_block = 1;
	else if (key_glass)
		selected_block = 2;
}

//Animate
animate_building = lerp(animate_building, (action_state == "BUILD"), 0.12);

//health jam animation
health_jam_animation = lerp(health_jam_animation, (1-hp/max_hp)*100, 0.1);