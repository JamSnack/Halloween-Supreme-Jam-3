/// @description Insert description here
// You can write your code in this editor
draw_self();

if (hp < max_hp)
	draw_healthbar(x - 8, y-1, x + 8, y+1, (hp/max_hp)*100, c_black, c_red, c_green, 0, true, false);