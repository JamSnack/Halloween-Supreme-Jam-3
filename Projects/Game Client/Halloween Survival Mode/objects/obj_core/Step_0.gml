/// @description Insert description here
// You can write your code in this editor
if (free_surface_candy_pile)
{
	surface_free(surface_candy_pile);
	free_surface_candy_pile = false;
}

draw_contents =	approach(draw_contents, point_in_rectangle(MOUSE_X_IN_WORLD, MOUSE_Y_IN_WORLD, x - range, y - range, x + range, y + range) ? 1 : -1, 0.1);

if (draw_contents)
	depth = -999-y;
else depth = -y;