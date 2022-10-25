function get_next_id()
{
	global.next_id += 1;
	
	if (global.next_id > 9999)
		global.next_id = 0;
	
	return global.next_id;
}

function approach(value, target, rate)
{
	if (argument0 < argument1)
	    return min(argument0 + argument2, argument1); 
	else
	    return max(argument0 - argument2, argument1);	
}

function scr_move_toward_point(target_x, target_y, move_speed)
{
	//Sets x_speed and y_speed of the instance
	var x_dir = sign(target_x - x + 1);
	var y_dir = sign(target_y - y + 1);
			
	x_speed = approach(x_speed, x_dir * move_speed, torque);
	y_speed = approach(y_speed, y_dir * move_speed, torque);
			
	//horizontal movement
	if (collision_rectangle(bbox_left + x_speed, bbox_top, bbox_right + x_speed, bbox_bottom, entity_block, false, true))
	{	
		repeat(10)
		{
			if (collision_rectangle(bbox_left + x_dir, bbox_top, bbox_right + x_dir, bbox_bottom, entity_block, false, true) == noone )
				x += x_dir;
			else break;
		}
				
		x_speed = -x_speed*bounce_factor;
	}
			
	x += x_speed;
			
			
			
	//vertical movement
	if (collision_rectangle(bbox_left, bbox_top + y_speed, bbox_right, bbox_bottom + y_speed, entity_block, false, true))
	{
		repeat(10)
		{
			if (collision_rectangle(bbox_left, bbox_top + y_dir, bbox_right, bbox_bottom + y_dir, entity_block, false, true) == noone )
				y += y_dir;
			else break;
		}
				
		y_speed = -y_speed*bounce_factor;
	}
			
	y += y_speed;
	
	//update object on client
	moved = true;
}

function scr_get_generic_enemy()
{
	if (global.game_stage < 20)
		return choose(entity_fast_enemy, entity_jumpkin);
	else if (global.game_stage > 20)
		return choose(entity_fast_enemy, entity_fast_enemy, entity_jumpkin, entity_jumpkin, entity_zombie, entity_troopie);
	else if (global.game_stage > 40)
		return choose(entity_fast_enemy, entity_jumpkin, entity_zombie, entity_troopie, entity_scarecrow);
		
	
	
	//Default return case
	return choose(entity_fast_enemy, entity_jumpkin, entity_troopie, entity_zombie, entity_scarecrow, entity_tender_spirit);
}

function scr_get_boss()
{
	if (global.game_stage > 5)
		return entity_pigyamo;
}

function scr_death_message(playername)
{	
	switch (irandom(25))
	{
		case 0: { playername += " died while smelling the roses."; } break;
		case 1: { playername += " had too much candy!"; } break;
		case 2: { playername += " had too little candy!"; } break;
		case 3: { playername += " won't see the squad again."; } break;
		case 4: { playername += " didn't survive Halloween."; } break;
		case 5: { playername += " was slaughtered."; } break;
		case 6: { playername += " was impaled. Twice."; } break;
		case 7: { playername += " figured out what happens at 0 HP."; } break;
		case 8: { playername += " turned into fertilizer."; } break;
		case 9: { playername += " became Greenthin feed."; } break;
		case 10: { playername = "We won't be seeing " + playername + " anymore."; } break;
		case 11: { playername = "RIP " + playername } break;
		case 12: { playername += " was impaled."; } break;
		case 13: { playername += " has logged off."; } break;
		case 14: { playername += " was plundered and torn asunder by a teeny foul thing."; } break;
		case 15: { playername += " isn't having a very good day."; } break;
		case 16: { playername += " has gone missing! Last seen with Jumpkin Bob."; } break;
		case 17: { playername = "The surface area of " + playername + "'s body was forcefully increased."; } break;
		case 18: { playername += " and " + choose("Red Treat", "Teal Treat", "Yellow Treat", "Green Treat") + " did not mix."; } break;
		case 19: { playername += " lost a revive! Way to go!"; } break;
		case 20: { playername += " is now road nachos."; } break;
		case 21: { playername += " Cry hard die trying"; } break;
		default: { playername += " has died."; }
	}
	
	send_announcement(playername);
}

function scr_create_enemy_projectile(x, y, target_x, target_y, speed, object)
{
	var _i = instance_create_layer(x, y, "Instances", object);
	_i.speed = speed;
	_i.direction = point_direction(x, y, target_x, target_y);
	_i.image_angle = _i.direction;
	
	//Send projectile to players
	var _d = ds_map_create();
	_d[? "cmd"] = "enemy_shoot";
	_d[? "d"] = _i.direction;
	_d[? "s"] = speed;
	_d[? "x"] = x;
	_d[? "y"] = y;
	//_d[? "ind"] = object;
	send_data(_d);
}