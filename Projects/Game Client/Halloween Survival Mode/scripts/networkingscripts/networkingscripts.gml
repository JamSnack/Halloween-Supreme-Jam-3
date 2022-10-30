// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function joinLobby(lobby_id)
{
	//server_status = "Connecting to server...";
	global.socket = network_create_socket(network_socket_tcp);
	
	//Try to connect to the main server.
	var _s = network_connect_raw(global.socket, "161.35.5.62", 55555);
	
	if (_s >= 0)
	{
		//after we've connected to the main server, attempt to join the desired lobby:
		lobby_search(lobby_id);
	}	
}

function send_data(data_map)
{
	var json_map = json_encode(data_map);
	var buff = buffer_create(128, buffer_grow, 1);
	
	buffer_seek(buff, buffer_seek_start, 0);
	var _header = buffer_write(buff, buffer_text, string(string_byte_length(json_map)) + "|");
	var _b = buffer_write(buff, buffer_text, json_map);
	
	if (_header == -1) then show_debug_message("header write failed.");
	if (_b == -1) then show_debug_message("buffer_write failed.");
	
	//show_debug_message(json_map);
	var packet_sent = network_send_raw(global.socket, buff, buffer_tell(buff)); //final argument is optional here
		
	if (packet_sent == 0)
	{
		//the send has failed. We need to try again later.
		show_debug_message("FAILED TO SEND: PACKET IS " +string(data_map[? "cmd"]));
	}// else global.packets_sent++;
	
	//cleanup
	buffer_delete(buff);
	ds_map_destroy(data_map);
}

function send_data_raw(data_map)
{
	var json_map = json_encode(data_map);
	var buff = buffer_create(128, buffer_grow, 1);
	
	buffer_seek(buff, buffer_seek_start, 0);
	var _b = buffer_write(buff, buffer_string, json_map);
	
	if (_b == -1) then show_debug_message("buffer_write failed.");
	
	//show_debug_message(json_map);
	var packet_sent = network_send_raw(global.socket, buff, buffer_tell(buff)); //final argument is optional here
		
	if (packet_sent == 0)
	{
		//the send has failed. We need to try again later.
		show_debug_message("FAILED TO SEND: PACKET IS " +string(data_map[? "cmd"]));
	}// else global.packets_sent++;
	
	//cleanup
	buffer_delete(buff);
	ds_map_destroy(data_map);
}

function handle_data(data)
{	
	var parsed_data = json_decode(data);
	//show_debug_message("Handling data: "+string(data));
	
	if (parsed_data != -1)
	{
		switch parsed_data[? "cmd"]
		{	
			case "lobby_connect_success": 
			{ 
				global.lobby_id = parsed_data[? "l_id"]; 
				global.player_id = parsed_data[? "plr_id"];
			} 
			break;
			case "player_pos":
			{
				var pl_id =  parsed_data[? "p_id"];
				var _x = parsed_data[? "x"];
				var _y = parsed_data[? "y"];
				
				//update current client's position
				if (global.player_id == pl_id)
				{
					obj_player.x = _x;
					obj_player.y = _y;
				}
				else
				{
					var instance_updated = false;
					
					//update another player's position
					with (obj_player_entity)
					{
						if (pl_id == p_id)
						{
							x = _x;
							y = _y;
							
							if (_xscale != 0)
								image_xscale = _xscale;
							
							despawn_timer = despawn_timer_set;
							
							instance_updated = true;
							break;
						}
					}
					
					//Create a dummy for a new player
					if (!instance_updated)
					{
						var _p = instance_create_layer(_x, _y, "Instances", obj_player_entity);
						_p.p_id = pl_id;
					}
				}
			}
			break;
			
			case "chat":
			{
				chat_overlay.append("[" + parsed_data[? "n"] + "]" + ": " + parsed_data[? "t"]);
			}
			break;
			
			case "announcement":
			{
				chat_overlay.append(">" + parsed_data[? "t"]);
			}
			break;
			
			case "player_disconnected":
			{
				var pl_id = parsed_data[? "p_id"];
				var _p_n = string(pl_id);
				
				with (obj_player_entity)
				{
					if (pl_id == p_id)
					{
						_p_n = p_n;
						instance_destroy();
						break;
					}
				}
				
				chat_overlay.append(_p_n + " has disconnected.");
			}
			break;
			
			case "player_connected":
			{
				var _id = real(parsed_data[? "p_id"]);
				var _pn = parsed_data[? "p_n"];
				
				if (_id != global.player_id)
				{
					var _p = instance_create_layer(100, 100, "instances", obj_player_entity);
					_p.p_id =_id;
					_p.p_n = _pn;
				}
				
				chat_overlay.append(_pn + " joined the game.");
			}
			break;
			
			case "player_name_recieved":
			{
				var pl_id = parsed_data[? "p_id"];
				
				with (obj_player_entity)
				{
					if (pl_id == p_id)
					{
						p_n = parsed_data[? "p_n"];
						break;
					}
				}
			}
			break;
			
			case "enemy_pos":
			{
				var e_id = parsed_data[? "e_id"];
				var instance_updated = false;
				
				with (obj_enemy_entity)
				{
					if (e_id == enemy_id)
					{
						x = parsed_data[? "x"];
						y = parsed_data[? "y"];
							
						/*if (_xscale != 0)
							image_xscale = _xscale;*/
							
						despawn_timer = despawn_timer_set;
							
						instance_updated = true;
						break;
					}
				}
				
				//if we didn't update an instance: ask the server for the instance
				if (!instance_updated)
				{
					var _d = ds_map_create();
					_d[? "cmd"] = "request_enemy_entity";
					_d[? "e_id"] = e_id;
					send_data(_d);
					
					show_debug_message("Request Enemy");
				}
			}
			break;
			
			case "create_enemy":
			{
				var _e_id = parsed_data[? "e_id"];
				
				//does an enemy with this id already exist?
				if (instance_exists(obj_enemy_entity))
				{
					with (obj_enemy_entity)
					{
						if (enemy_id == _e_id)
							return;
					}
				}
				
				var _e = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", obj_enemy_entity)
				_e.max_hp = parsed_data[? "mhp"];
				_e.hp = parsed_data[? "hp"];
				_e.enemy_id = _e_id;
				_e.enemy_image_data = parsed_data[? "o_i"];
				
				with (_e)
					scr_select_enemy_sprites(enemy_image_data);
				
				//show_debug_message("Create Enemy");
			}
			break;
			
			case "create_item":
			{
				var _e = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", obj_item_entity);
				_e.item_id = parsed_data[? "i_id"];
				_e.image_index = parsed_data[? "index"];
			}
			break;
			
			case "item_pos":
			{
				var i_id = parsed_data[? "i_id"];
				var instance_updated = false;
				
				with (obj_item_entity)
				{
					if (i_id == item_id)
					{
						x = parsed_data[? "x"];
						y = parsed_data[? "y"];
							
						despawn_timer = despawn_timer_set;
							
						instance_updated = true;
						break;
					}
				}
				
				//if we didn't update an instance: ask the server for the instance
				if (!instance_updated)
				{
					var _d = ds_map_create();
					_d[? "cmd"] = "request_item_entity";
					_d[? "i_id"] = i_id;
					send_data(_d);
				}
			}
			break;
			/*
			case "item_pickup":
			{
				var pl_id = parsed_data[? "p_id"];
				
				if (pl_id == global.player_id)
					if (!client_inventory.is_full())
						client_inventory.add(parsed_data[? "index"]);
			}
			break;*/
			
			case "enemy_destroy":
			{
				//show_debug_message("enemy_destroy!");
				var e_id = parsed_data[? "e_id"];
				
				with (obj_enemy_entity)
				{
					if (e_id == enemy_id)
					{
						//destroy
						instance_destroy();
						
						//effects
						repeat(parsed_data[? "amt"])
						{
							if (instance_exists(obj_core) && parsed_data[? "k_id"] == global.player_id)
							{
								var _t = instance_create_layer(x, y, "Instances", efct_treat_to_player);
								_t.image_index = parsed_data[? "candy"];
							}
						}
						
						//break
						break;
					}
				}
			}
			break;
			
			case "game_timer_update":
			{
				global.game_timer = parsed_data[? "time"];
			}
			break;
			
			case "tile_place":
			{
				if (parsed_data[? "p_id"] != -1 && parsed_data[? "p_id"] != global.player_id)
					return;
				
				var _t_id = parsed_data[? "t_id"];
				//does an effect in-flight with this id already exist?
				if (global.use_effects)
				{
					if (instance_exists(efct_place_tile))
					{
						with (efct_place_tile)
						{
							if (_t_id == object_id)
								return;
						}
					}
				}
				
				//Does a currently placed tile with this ID exist?
				if (instance_exists(obj_block_entity))
				{
					with (obj_block_entity)
					{
						if (_t_id == tile_id)
							return;
					}
				}
				
				//Continue...
				var _type = parsed_data[? "type"];
				
				switch (_type)
				{
					case 0: { _type = obj_block_entity; } break;
					case 1: { _type = obj_block_door_entity; } break;
					case 2: { _type = obj_block_glass_entity; } break;
					case BUILD.false_block: { _type = obj_false_block; } break;
					case BUILD.last: { _type = obj_core; } break;
				}
				
				if (global.use_effects && _type != obj_false_block)
				{
					var _t = instance_create_layer(CENTER_X, CENTER_Y, "Instances", efct_place_tile);
					_t.object = _type;
					_t.sprite_index = object_get_sprite(_type);
					_t.hp = parsed_data[? "hp"];
					_t.max_hp = parsed_data[? "mhp"];
					_t.object_id = _t_id;
					_t.target_x = parsed_data[? "x"];
					_t.target_y = parsed_data[? "y"];
				}
				else
				{
					var _t = instance_create_layer(parsed_data[? "x"], parsed_data[? "y"], "Instances", _type);
					_t.hp = parsed_data[? "hp"];
					_t.max_hp = parsed_data[? "mhp"];
					_t.tile_id = parsed_data[? "t_id"];
				}
			}
			break;
			
			case "tile_destroy":
			{
				var t_id = parsed_data[? "t_id"];
				
				if (t_id == -2)
				{
					//This is a position-specific destroy
					var _x = parsed_data[? "x"];
					var _y = parsed_data[? "y"];
					instance_activate_region(_x-1, _y-1, _x, _y, true);
					
					if (instance_exists(obj_block_entity))
					{
						var _c = collision_point(_x, _y, obj_block_entity, false, true);
					
						if (_c != noone)
							with (_c)
								instance_destroy();
					}
				}
				else if (instance_exists(obj_block_entity))
				{
					with(obj_block_entity)
					{
						if (t_id == tile_id)
						{
							instance_destroy();
							break;
						}
					}
				}
			}
			break;
			
			case "tile_update":
			{
				var _x = parsed_data[? "x"];
				var _y = parsed_data[? "y"];
				
				instance_activate_region(_x-1, _y-1, _x, _y, true);
				
				if (instance_exists(obj_block_entity))
				{
					var _t = collision_point(_x, _y, obj_block_entity, false, true);
					
					if (_t != noone)
						_t.hp = parsed_data[? "hp"];	
				}
			}
			break;
			
			case "enemy_update":
			{
				
				var e_id = parsed_data[? "e_id"];
				var instance_updated = false;
				
				if (instance_exists(obj_enemy_entity))
				{
					with (obj_enemy_entity)
					{
						if (e_id = enemy_id)
						{
							hp = parsed_data[? "hp"];
							
							//assume hp set here will always be a decrease
							damage_animation = 1;
							instance_updated = true;
							break;
						}
					}
				}
				
								
				//if we didn't update an instance: ask the server for the instance
				if (!instance_updated)
				{
					var _d = ds_map_create();
					_d[? "cmd"] = "request_enemy_entity";
					_d[? "e_id"] = e_id;
					send_data(_d);
					
					show_debug_message("Request Enemy");
				}
			}
			break;

			case "projectile_shoot":
			{
				var _x = parsed_data[? "x"];
				var _y = parsed_data[? "y"];
				
				var _s = instance_create_layer(_x, _y, "Instances", obj_projectile);
				_s.direction = parsed_data[? "d"];
				_s.image_angle = _s.direction;
				_s.speed = parsed_data[? "s"];
				_s.proj_id = parsed_data[? "id"];
				_s.sprite_index = scr_select_projectile_sprites(parsed_data[? "indx"]);
				_s.friction = parsed_data[? "f"];
			}
			break;
			
			case "projectile_destroy":
			{
				if (instance_exists(obj_projectile))
				{
					var pr_id = parsed_data[? "id"];
					with (obj_projectile)
					{
						if (pr_id == proj_id)
						{
							instance_destroy();
							break;	
						}
					}
				}
			}
			break;
			
			case "player_hp":
			{
				var pl_id = parsed_data[? "p_id"];
				
				if (pl_id == global.player_id)
				{
					obj_player.hp = parsed_data[? "hp"];
				}
				else
				{
					var _h = parsed_data[? "hp"];
					var _mh = parsed_data[? "mhp"];
					
					with (obj_player_entity)
					{
						if (pl_id = p_id)
						{
							hp = _h;
							max_hp = _mh;
							break;
						}
					}
				}
			}
			break;
			
			case "update_core_builds_at_index": { obj_core.builds_stored[parsed_data[? "index"]] = parsed_data[? "amt"]; } break;
			
			case "update_core_candies_at_index":
			{ 
				if (instance_exists(obj_core))
				{
					obj_core.candies_stored[parsed_data[? "index"]] = parsed_data[? "amt"]; 
					obj_core.free_surface_candy_pile = true;
				}
			} 
			break;
			
			case "effect_player_candy_to_core" :
			{
				if (instance_exists(obj_core) && point_distance(obj_player.x, obj_player.y, obj_core.x, obj_core.y) > 128)
				{
					var _r = parsed_data[? "amt"];
					var _x = parsed_data[? "x"];
					var _y = parsed_data[? "y"];
					var _index = parsed_data[? "t"];
				
					repeat(_r)
					{
						var _c = instance_create_layer(_x, _y, "Instances", efct_treat_to_player);
						_c.target = noone; //auto travels to the core
						_c.image_index = _index;
					}
				}
			}
			
			case "xp":
			{
				if (parsed_data[? "a"] != undefined)
				{
					create_pop_message(parsed_data[? "x"], parsed_data[? "y"], "+" + string(parsed_data[? "a"]), c_fuchsia);
				
					if (global.player_id == parsed_data[? "p_id"])
						xp += parsed_data[? "a"];
				}
			}
			break;
			
			case "level":
			{
				create_pop_message(parsed_data[? "x"], parsed_data[? "y"], "Level " + string(parsed_data[? "l"]) + "!", c_lime);
				
				if (parsed_data[? "p_id"] = global.player_id)
				{
					xp = parsed_data[? "xp"];
					xp_needed = parsed_data[? "xp_need"];
					level = parsed_data[? "l"];
				}
			}
			break;
			
			case "damage":
			{
				create_pop_message(parsed_data[? "x"], parsed_data[? "y"], string(parsed_data[? "d"]), c_red);
			}
			
			case "update_stats":
			{
				if (global.player_id == parsed_data[? "p_id"])
				{
					skillpoints = parsed_data[? "skps"];
					obj_player.max_hp = parsed_data[? "mhp"];
					obj_player.hp = parsed_data[? "hp"];
					
					for (var _i = 0; _i < array_length(player_stats); _i++)
					{
						player_stats[_i] = parsed_data[? string(_i)];
					}
				}
				
				//show_debug_message("updated stats");
			}
			break;
			
			case "core_revives":
			{
				global.revives_remaining = parsed_data[? "r"];
			}
			break;
			
			case "request_player_colors":
			{
				networking_send_player_colors();
			}
			break;

			case "player_colors":
			{
				var pl_id = parsed_data[? "p_id"];
				
				with (obj_player_entity)
				{
					if (pl_id == p_id)
					{
						show_debug_message("setting entity colors");
						
						for (var _i = 0; _i < 6*3; _i++)
						{
							var _c = parsed_data[? "c"+string(_i)];
							var _index = _i mod 3;
							
							show_debug_message("color is: " + string(_c));
							
							switch (_i)
							{
								case 0: 
								case 1:
								case 2: { skin_light[_index] = _c; } break;
								
								case 3: 
								case 4:
								case 5: { skin_dark[_index] = _c; } break;
								
								case 6: 
								case 7:
								case 8: { shirt_light[_index] = _c; } break;
								
								case 9: 
								case 10:
								case 11: { shirt_dark[_index] = _c; } break;
								
								case 12: 
								case 13:
								case 14: { pants_light[_index] = _c; } break;
								
								case 15: 
								case 16:
								case 17: { pants_dark[_index] = _c; } break;
							}
						}
						
						show_debug_message("set entity colors");
						break;
					}
				}
			}
			break;
			
			case "update_held_candy":
			{
				if (parsed_data[? "p_id"] == global.player_id)
				{
					for (var _i = 0; _i < CANDY.last; _i++)
						global.held_candy[_i] = parsed_data[? string(_i)];
						
					//update_held_candy = true;
						
				}
			}
			break;

		}
	}
}