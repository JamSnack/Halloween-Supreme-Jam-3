/// @description Insert description here
// You can write your code in this editor

//Color swapping shader
shader_set(shd_colorSwap);
shader_set_uniform_f_array(global.uniform_defaultPalette, );
shader_set_uniform_f_array(global.uniform_newPalette, );
 
event_inherited();
 
shader_reset();


