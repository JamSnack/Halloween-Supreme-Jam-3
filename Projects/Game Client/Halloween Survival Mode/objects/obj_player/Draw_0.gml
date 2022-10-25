/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
shader_set(shd_swapColors);
scr_shader_swapColors_set_uniforms(REPLACE_SHIRT_LIGHT_ID, REPLACE_SHIRT_DARK_ID, REPLACE_SKIN_LIGHT_ID, REPLACE_SKIN_DARK_ID, REPLACE_PANTS_LIGHT_ID, REPLACE_PANTS_DARK_ID);
event_inherited();
shader_reset();
	
//Draw action state
draw_text(x, y+12, string(action_state));

if (action_state == "BUILD")
{
	draw_sprite(spr_tile_placement, 0, MOUSE_X_IN_WORLD, MOUSE_Y_IN_WORLD);;
}