/// @description Insert description here
// You can write your code in this editor

if (point_distance(draw_x, draw_y, x, y) < 10)
{
	draw_x = lerp(draw_x, x, interpolation_rate);
	draw_y = lerp(draw_y, y, interpolation_rate);
}
else { draw_x = x; draw_y = y; }


//Death timer
if (destroy_timer != -1 && destroy_timer > 0)
{
	destroy_timer--;
	
	if (destroy_timer == 0)
		instance_destroy();	
}