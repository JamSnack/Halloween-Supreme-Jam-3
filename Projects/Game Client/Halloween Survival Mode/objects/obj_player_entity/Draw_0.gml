/// @description Insert description here

//Draw username
draw_set_halign(fa_center);
draw_set_font(fnt_default);

if (p_n != "")
	draw_text(draw_x, draw_y + 8, p_n);
	

//reset
draw_set_halign(fa_left);

// Inherit the parent event
shader_set(shd_swapColors);
scr_shader_swapColors_set_uniforms(shirt_light, shirt_dark, skin_light, skin_dark, pants_light, pants_dark);
event_inherited();
shader_reset();

//hp
if (hp < max_hp)
	draw_healthbar(draw_x - 8, draw_y - 1 + 2, draw_x + 8, draw_y + 1 + 2, (hp/max_hp)*100, c_black, c_red, c_green, 0, true, true);
