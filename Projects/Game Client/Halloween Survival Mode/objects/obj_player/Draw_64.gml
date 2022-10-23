/// @description
//Drawp HP Vial

//surface
if (!surface_exists(health_surface))
	health_surface = surface_create(80, 80);

surface_set_target(health_surface);

//draw sprite
draw_sprite(spr_ui_health_vial_sillhouette, 0, 0, 0);

//apply sprite overlay
gpu_set_colorwriteenable(1, 1, 1, 0);

draw_sprite(spr_ui_health_vial_jam_filling, 0, 0, health_jam_animation);

gpu_set_colorwriteenable(1, 1, 1, 1);

//reset
surface_reset_target();

//draw
draw_surface(health_surface, 10, 5);
draw_sprite(spr_ui_health_vial, 0, 10, 5);

draw_set_font(fnt_default);
draw_set_halign(fa_center);
draw_text(50, 23, string(hp) + "\n\n\n\n" + string(max_hp) );
draw_set_halign(fa_left);