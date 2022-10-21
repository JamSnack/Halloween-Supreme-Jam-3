// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
#macro TIME floor(current_time/100)

global.uniform_defaultPalette = shader_get_uniform(shd_colorSwap, "defaultPalette");
global.uniform_newPalette = shader_get_uniform(shd_colorSwap, "newPalette");

global.defaultPalette = array_create(6, 0);

//skin
//global.defaultPalette[0] = 