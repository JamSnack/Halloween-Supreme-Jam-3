/// @description Insert description here
// You can write your code in this editor

if (point_distance(draw_x, draw_y, x, y) < 10)
{
	draw_x = lerp(draw_x, x, interpolation_rate);
	draw_y = lerp(draw_y, y, interpolation_rate);
}
else { draw_x = x; draw_y = y; }