/// @description Draw GUI

//Draw Inventory
//Draw Character Sheet
if (draw_character_sheet > 0)
{
	var _alpha = 1 - animcurve_channel_evaluate(global.fade_curve, draw_character_sheet);
	
	var _x = GUI_WIDTH/2;
	var _y = GUI_HEIGHT/2;
	
	//Draw background
	draw_sprite_ext(spr_ui_character_sheet, 0, GUI_WIDTH/2, GUI_HEIGHT/2, _alpha, _alpha, 0, c_white, _alpha);
	
	//Draw player sprite
	draw_sprite_ext(spr_player_idle, 0, _x - 152*_alpha, _y - 105*_alpha, 5*_alpha, 5*_alpha, 0, c_white, _alpha);
	
	//Draw Name
	draw_set_halign(fa_center);
	draw_set_font(fnt_ink_free);
	draw_text_transformed(_x + 120*_alpha, _y - 250*_alpha, global.player_name, _alpha, _alpha, 0);
	
	//Draw level
	draw_text_transformed(_x + 120*_alpha, _y - 200*_alpha, "Level: " + string(level), _alpha, _alpha, 0);
	
	//Draw skillpoints
	draw_text_transformed(_x + 120*_alpha, _y - 130*_alpha, "Skillpoints: " + string(skillpoints), _alpha, _alpha, 0);
	
	//Draw Stats
	draw_set_halign(fa_left);
	
	for (var _s = 0; _s < array_length(player_stats); _s++)
	{
		var str = "";
		
		switch (_s)
		{
			case STATS.hp: { str = "HP: "; } break;
			case STATS.movespeed: { str = "Speed: "; } break;
			case STATS.attack: { str = "Attack: "; } break;
			case STATS.attack_speed: { str = "Attack Speed: "; } break;
		}
		
		//- main string
		str += string(player_stats[_s]);
		
		//- bonus stats
		if (instance_exists(obj_core))
		{
			switch (_s)
			{
				case STATS.hp: { str += " + (" + string(STAT_HP) + ")"; } break;
				case STATS.movespeed: { str += " + (" + string(STAT_SPEED) + ")"; } break;
				case STATS.attack: { str += " + (" + string(STAT_ATTACK) + ")"; } break;
			}
		}
		
		//draw stat
		draw_text_transformed(_x - 230*_alpha, _y - 20*_alpha + _s*_alpha*40, str, _alpha, _alpha, 0);
		
		//draw button
		draw_sprite(spr_ui_character_sheet_button, 0, _x - 245*_alpha, _y -10*_alpha + _s*_alpha*40);
		
		var _x1 = GUI_WIDTH/2 - 245;
		var _y1 = GUI_HEIGHT/2 -10 + 40*_s;
		draw_rectangle(_x1, _y1, _x1 + 9, _y1 + 9, false);
	}
}

//reset
draw_set_halign(fa_left);

//Draw chat
draw_set_font(fnt_menu_text);
draw_set_alpha(global.chat_alpha);

var _chat = chat_overlay.text + "\n-----------------\n";
var _chat_text = (global.chatting) ? chat_overlay.chat_text : "Press 'Enter' to chat.";

if (_chat_text = "")
	_chat_text = "|"

draw_text(4, 450, _chat);
draw_text(4, 450+200, _chat_text);

draw_set_alpha(1);

//Draw XP bar
draw_set_color(c_black);
draw_rectangle(0, GUI_HEIGHT - 10, GUI_WIDTH, GUI_HEIGHT, false);
draw_set_color(c_white);
if (xp_draw != xp) then draw_rectangle(0, GUI_HEIGHT - 10, GUI_WIDTH * (xp/xp_needed), GUI_HEIGHT, false);
draw_set_color(c_purple);
draw_rectangle(0, GUI_HEIGHT - 10, GUI_WIDTH * (xp_draw/xp_needed), GUI_HEIGHT, false);
draw_set_color(c_white);
draw_text(GUI_WIDTH - 80, GUI_HEIGHT - 30, "Lv. " + string(level));


/*
for (var i = 0; i < global.inventory_size; i++)
{
	var _square = 48;
	var _x = global.display_width/2 - global.inventory_size*(_square+8)/2 + i*(_square+8);
	
	draw_rectangle(_x, global.display_height-80, _x+_square, global.display_height-80+_square,false);
	
	if (client_inventory.inven[i] != 0)
		draw_sprite(spr_player, 0, _x + 24, global.display_height-80 + 24);
}
*/