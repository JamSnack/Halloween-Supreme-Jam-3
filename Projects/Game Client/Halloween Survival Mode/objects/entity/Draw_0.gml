/// @description Entity Interpolation

//Draw shadow
draw_sprite(spr_shadow, 0, draw_x, draw_y);

//draw sprite damaged or normal
if (damage_animation > 0)
{
	var damage_scale = animcurve_channel_evaluate(global.pop_curve, damage_animation);
	
	draw_sprite_ext(sprite_index, image_index, draw_x, draw_y, image_xscale + (image_xscale*damage_scale), image_yscale + (image_yscale*damage_scale), 0, c_white, 1);
}
else draw_sprite_ext(sprite_index, image_index, draw_x, draw_y, image_xscale, image_yscale, 0, c_white, 1);