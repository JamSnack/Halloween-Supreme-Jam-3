/// @description Insert description here

//Draw username
draw_set_halign(fa_center);

if (p_n != "")
	draw_text(x, y + 8, p_n);
	

//reset
draw_set_halign(fa_left);

// Inherit the parent event
event_inherited();

