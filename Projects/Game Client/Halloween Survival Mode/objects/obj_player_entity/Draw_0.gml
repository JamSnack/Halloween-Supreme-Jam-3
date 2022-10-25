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
