/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

//draw healthbar
if (hp < max_hp)
	draw_healthbar(x - 8, y + 6, x + 8, y + 9, (hp/max_hp)*100, c_black, c_red, c_green, 0, true, false);
	
//Draw action state
draw_text(x, y+12, string(action_state));