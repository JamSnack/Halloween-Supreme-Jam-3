/// @description Insert description here
// You can write your code in this editor
if (imguigml_ready())
{
	if (room == rm_zero)
	{
		var _s = 300;
		imguigml_set_next_window_pos(global.display_width/2 - _s/2, 80);
		imguigml_set_next_window_size(_s, 300);
		
		imguigml_begin("Multiplayer");
		
		imguigml_text("Enter Username:");
		global.player_name = imguigml_input_text(" ", global.player_name, 12)[1];
		
		if (global.player_name == "")
			global.player_name = ">:)";
		
		imguigml_text("Enter Lobby ID:");
		stored_lobby_id = imguigml_input_text("", stored_lobby_id, 5)[1]; //returns imguigml_input_text at [1], which is the text feild portion of the array.
		var join_lobby = imguigml_button("Join Lobby");
	
		if (join_lobby)
			joinLobby(stored_lobby_id);
		
		//Draw stuff
		var l_text = (global.lobby_id == -1) ? "No lobby entered." : string(global.lobby_id);
		
		imguigml_text("Lobby ID: " + l_text);
		
		//execute lobby
		if (imguigml_button("Host Lobby"))
			execute_lobby();
		
		imguigml_end();
	}
}

//Have we successfully found a lobby?
if (global.lobby_id != -1 && room == rm_zero)
{
	room_goto(rm_world);
	chat_overlay.append("Welcome to Treat Squad, " + string(global.player_name) + "!\nWorld: "+string(global.lobby_id));
}

//Chatting
var chat_key = keyboard_check_released(vk_enter);
	
//show_debug_message(string(global.chatting));	

if (global.chatting)
{
	if (chat_key)
	{
		chat_overlay.send_chat();
		global.chatting = false;
		keyboard_string = "";
	}
	else
	{
		if (string_length(keyboard_string) < 42)
			chat_overlay.chat_text = keyboard_string;
		else keyboard_string = chat_overlay.chat_text;
	}
}
else if (chat_key)
{
	global.chatting = true;
	keyboard_string = "";
}

global.chat_alpha = approach(global.chat_alpha, global.chatting, 0.0025 + 0.09*global.chatting);

//XP
xp_draw = lerp(xp_draw, xp, 0.1);

//Character Sheet
if (!global.chatting && keyboard_check_released(ord("G")))
	draw_character_sheet_target = !draw_character_sheet_target;
	
draw_character_sheet = approach(draw_character_sheet, draw_character_sheet_target, 0.1);

//ALLOCATE SKILLPOINTS
var px = device_mouse_x_to_gui(0);
var py = device_mouse_y_to_gui(0);

if (draw_character_sheet == 1)
{
	var _x1 = GUI_WIDTH/2 - 245;
	var _y1 = GUI_HEIGHT/2 -10;
	//show_debug_message(string(point_in_rectangle(px, py, _x1, _y1, _x1+9, _y1+9)));
	
	for (var _s = 0; _s < STATS.last; _s++)
	{	
		if (!global.chatting && mouse_check_button_released(mb_left) && point_in_rectangle(px, py, _x1, _y1 + _s*40, _x1+9, _y1 + 9 + _s*40))
		{
			var _d = ds_map_create();
			_d[? "cmd"] = "request_skill_up";
			_d[? "index"] = _s;
			_d[? "pl_id"] = global.player_id;
			send_data(_d);
		}
	}	
}

//Mob naming
if (instance_exists(obj_enemy_entity))
{
	var _e = instance_nearest(mouse_x, mouse_y, obj_enemy_entity);

	if (point_in_rectangle(mouse_x, mouse_y, _e.bbox_left, _e.bbox_top, _e.bbox_right, _e.bbox_bottom))
		cursor_text = scr_get_enemy_name(_e.enemy_image_data) + "\n" + string(_e.hp) + "/" + string(_e.max_hp);
	else cursor_text = "";
}
else cursor_text = "";

//keep things in menu stable
if (room == rm_zero)
{
	global.chatting = false;
	draw_character_sheet = 0;
	draw_character_sheet_target = 0;
}

ping += 1;

//Cyclical requests for enemies:
if (update_enemy_delay <= 0)
{
	if (enemy_update_index < instance_number(obj_enemy_entity))
	{
		with (instance_find(obj_enemy_entity, enemy_update_index))
			request_enemy(enemy_id);
			
		update_enemy_delay = 5;
		enemy_update_index += 1;
	} 
	else enemy_update_index = 0;
}
else update_enemy_delay--;

//Cyclical requests for blocks:
if (update_block_delay <= 0)
{
	if (block_update_index < instance_number(obj_block_entity))
	{
		with (instance_find(obj_block_entity, block_update_index))
			request_tile_update(tile_id);
			
		update_block_delay = 5;
		block_update_index += 1;
	}
	else block_update_index = 0;
}
else update_block_delay--;