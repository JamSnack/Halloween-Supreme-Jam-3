/// @description Insert description here
// You can write your code in this editor
//Draw candy pile
var _size = 48;

if (!surface_exists(surface_candy_pile))
{
	surface_candy_pile = surface_create(_size*_size, _size*_size);
	surface_set_target(surface_candy_pile);
	
	for (var _c = 0; _c < array_length(candies_stored); _c++)
	{
		var _x = 20*_c;
		var _y = 30*_c;
		var _r = 1*_c;
		
		for (var _t = 0; _t < candies_stored[_c]; _t++)
		{
			//too much sugar!
			if (_t > 100)
				break;
			
			_x += 41+_t;
			_y += 36+_c;
			_r += 1+(_t+_c)*0.47;
			
			while (_x > _size*2 - 4)
				_x -= _size*2 - 4;
				
			while (_y > _size*2 - 4)
				_y -= _size*2 - 4;
				
			draw_sprite_ext(spr_shadow, 0, _x, _y + 2, 0.5, 0.5, _r, c_white, 1);
			draw_sprite_ext(spr_treats, _c, _x, _y, 0.5, 0.5, _r, c_white, 1);
		}
	}
	
	//reset
	surface_reset_target();
	
	draw_surface(surface_candy_pile, x - _size, y - _size);
}
else
{
	draw_surface(surface_candy_pile, x - _size, y - _size);	
}


//Draw Core tile sprite
event_inherited();

//Draw MENU
draw_set_font(fnt_menu_numbers);

if (draw_contents > 0)
{	
	//var h_size = 128;
	//var v_size = 128;
	var _scale = 2*draw_contents;
	var x_offset = -128*_scale;
	var y_offset = (-80 - 128)*_scale;
	
	draw_sprite_ext(spr_ui_hq_menu, 0, x + x_offset, y + y_offset, _scale, _scale, 0, c_white, 1);
	
	//draw buil amounts
	for (var i = 0; i < 3; i++)
	{
		var _x = x - 19*_scale + (35*i)*_scale;
		draw_text_transformed(_x, y - 17*_scale, string(candies_stored[i]), _scale, _scale, 0);
	}
	
	//draw treat amounts
	for (var i = 0; i < CANDY.last; i++)
		draw_text_transformed(x + x_offset + 40*_scale, y + 41*_scale + i*10*_scale + y_offset, string(candies_stored[i]), _scale, _scale, 0);
	
	//draw stats
	draw_text_transformed(x + x_offset + 80*_scale, y + y_offset + 153*_scale, string(STAT_SPEED), _scale, _scale, 0);
	draw_text_transformed(x + x_offset + 80*_scale, y + y_offset + 162*_scale, string(STAT_HP), _scale, _scale, 0);
	draw_text_transformed(x + x_offset + 80*_scale, y + y_offset + 172*_scale, string(STAT_ATTACK), _scale, _scale, 0);
	draw_text_transformed(x + x_offset + 80*_scale, y + y_offset + 182*_scale, string(STAT_ATTACK_SPEED), _scale, _scale, 0);
	draw_text_transformed(x + x_offset + 80*_scale, y + y_offset + 192*_scale, string(STAT_PROJ_SPEED), _scale, _scale, 0);
	
	draw_text_transformed(x + x_offset + 80*_scale, y + y_offset + 232*_scale, string(global.revives_remaining), _scale, _scale, 0);
}


