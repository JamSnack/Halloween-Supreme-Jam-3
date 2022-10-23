/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
	
//Draw action state
draw_text(x, y+12, string(action_state));

if (action_state == "BUILD")
{
	draw_sprite(spr_tile_placement, 0, MOUSE_X_IN_WORLD, MOUSE_Y_IN_WORLD);;
}