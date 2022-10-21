/// @description Draw GUI

//Draw Inventory
draw_set_font(fnt_menu_text);
draw_set_halign(fa_center);

/*if ( !instance_exists(obj_enemy_entity) )
{
	draw_text( GUI_WIDTH/2, GUI_HEIGHT - 20, "Intermission... " + string(global.game_timer) );
}
else
{
	draw_text( GUI_WIDTH/2, GUI_HEIGHT - 20, "Enemies Remaining: " + string( instance_number(obj_enemy_entity) ) );
}*/

//reset
draw_set_halign(fa_left);

//Draw chat
draw_set_alpha(global.chat_alpha);

var _chat = chat_overlay.text + "\n-----------------\n";
var _chat_text = (global.chatting) ? chat_overlay.chat_text : "Press 'Enter' to chat.";

if (_chat_text = "")
	_chat_text = "|"

draw_text(4, 450, _chat);
draw_text(4, 450+200, _chat_text);

draw_set_alpha(1);
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