/// @description
event_inherited();

if (hp < max_hp)
	draw_healthbar(draw_x - 8, draw_y - 1, draw_x + 8, draw_y + 1, (hp/max_hp)*100, c_black, c_red, c_green, 0, true, false);

