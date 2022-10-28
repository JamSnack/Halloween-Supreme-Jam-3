/// @description
//Drawp HP Vial

//health surface
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
draw_set_color(c_white);
draw_text(50, 23, string(hp) + "\n\n\n\n" + string(max_hp) );
draw_set_halign(fa_left);

//build action border and selected stuff
if (animate_building > 0)
{
	draw_set_color(c_blue);
	draw_sprite(spr_building, 0, GUI_WIDTH - 32*animate_building, -32 + 32*animate_building);
	draw_set_color(c_white);
}

var _a = BUILD.last-1;
var core_exists = instance_exists(obj_core);

for (var _i = 0; _i < _a; _i++)
{
	var _x = GUI_WIDTH/2 - _a*36 + 40*_i;
	var _y = -24;
		
	if (selected_block == _i && action_state == "BUILD")
	{	
		draw_sprite(spr_arrow_indicator, 0, 18 + _x, _y + 20 + 40*animate_building);
		draw_sprite(spr_building_stuff, _i, _x, _y + 20*animate_building);
		
		//block amt
		if (core_exists)
		{
			draw_set_color(c_white);
			draw_set_font(fnt_menu_numbers);
			draw_text(_x, _y + 40 + 20*animate_building, string(obj_core.candies_stored[_i]));
		}
	}
	else 
	{
		draw_sprite(spr_building_stuff, _i, _x, _y);
	
		//block amt
		if (core_exists)
		{
			draw_set_color(c_white);
			draw_set_font(fnt_menu_numbers);
			draw_text(_x, _y + 40, string(obj_core.candies_stored[_i]));
		}
	}
}

draw_sprite(spr_ui_shooting_indicator, 0, 700, -24 + 20*(1-animate_building));