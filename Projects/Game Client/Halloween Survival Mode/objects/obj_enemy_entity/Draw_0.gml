/// @description
event_inherited();

if (hp < max_hp)
	draw_healthbar(draw_x - 8, draw_y - 1 + 2, draw_x + 8, draw_y + 1 + 2, (hp/max_hp)*100, c_black, c_red, c_green, 0, true, true);

