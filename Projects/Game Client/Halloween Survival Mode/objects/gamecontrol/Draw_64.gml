/// @description Draw GUI

//Draw Inventory
for (var i = 0; i < global.inventory_size; i++)
{
	var _square = 48;
	var _x = global.display_width/2 - global.inventory_size*(_square+8)/2 + i*(_square+8);
	
	draw_rectangle(_x, global.display_height-80, _x+_square, global.display_height-80+_square,false);
	
	if (client_inventory.inven[i] != 0)
		draw_sprite(spr_player, 0, _x + 24, global.display_height-80 + 24);
}