// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
#macro TIME floor(current_time/100)
#macro GUI_WIDTH display_get_gui_width()
#macro GUI_HEIGHT display_get_gui_height()
#macro MOUSE_X_IN_WORLD floor(mouse_x/32)*32 + 16
#macro MOUSE_Y_IN_WORLD floor(mouse_y/32)*32 + 16
#macro CENTER_X 4000
#macro CENTER_Y 4000
#macro WORLD_WIDTH 8000
#macro WORLD_HEIGHT 8000
#macro SPAWN_X CENTER_X - 16
#macro SPAWN_Y CENTER_Y + 16


//Popular equations:
#macro STAT_HP ceil(100*(obj_core.candies_stored[CANDY.red]*0.001))
#macro STAT_SPEED 2*(obj_core.candies_stored[CANDY.green]*0.001)
#macro STAT_ATTACK ceil(25*(obj_core.candies_stored[CANDY.blue]*0.001))
#macro STAT_PROJ_SPEED ceil(4*(obj_core.candies_stored[CANDY.white]*0.001))
#macro STAT_ATTACK_SPEED ceil(4*(obj_core.candies_stored[CANDY.black]*0.001))

//Player colors
/*
Skin tone:
FFCAB0 - light
FAAD81 - Dark

Shirt tone:
6DD0F7 - light
00AEF0 - dark

Pants tone:
9E1F23 - light
990004 - dark
*/

globalvar colors, colors2, colors3, colors4, colors5, colors6, replace_colors, replace_colors2, replace_colors3, replace_colors4, replace_colors5, replace_colors6;
colors = array_create(3, 0);
colors2 = array_create(3, 0);
colors3 = array_create(3, 0);
colors4 = array_create(3, 0);
colors5 = array_create(3, 0);
colors6 = array_create(3, 0);

colors[0] = 255/255; //FF
colors[1] = 202/255; //CA
colors[2] = 176/255; //B0
#macro SKIN_LIGHT_ID colors

colors2 = array_create(3, 0);
colors2[0] = 250/255;
colors2[1] = 173/255;
colors2[2] = 129/255;
#macro SKIN_DARK_ID colors2


colors3[0] = 109/255;
colors3[1] = 208/255;
colors3[2] = 247/255;
#macro SHIRT_LIGHT_ID colors3

colors4[0] = 0;
colors4[1] = 174/255;
colors4[2] = 240/255;
#macro SHIRT_DARK_ID colors4

colors5[0] = 158/255;
colors5[1] = 31/255;
colors5[2] = 35/255;
#macro PANTS_LIGHT_ID colors5

colors6[0] = 153/255;
colors6[1] = 0;
colors6[2] = 4/255;
#macro PANTS_DARK_ID colors6


replace_colors = array_create(3, 0);
replace_colors2 = array_create(3, 0);
replace_colors3 = array_create(3, 0);
replace_colors4 = array_create(3, 0);
replace_colors5 = array_create(3, 0);
replace_colors6 = array_create(3, 0);

randomize();
var r1 = irandom(255)/255;
var r2 = irandom(255)/255;
var r3 = irandom(255)/255;

replace_colors[0] = r1;
replace_colors[1] = r2;
replace_colors[2] = r3;
#macro REPLACE_SHIRT_LIGHT_ID replace_colors

replace_colors2[0] = r1-0.25;
replace_colors2[1] = r2-0.25;
replace_colors2[2] = r3-0.25;
#macro REPLACE_SHIRT_DARK_ID replace_colors2

replace_colors3[0] = 255/255;
replace_colors3[1] = 202/255;
replace_colors3[2] = 176/255;
#macro REPLACE_SKIN_LIGHT_ID replace_colors3

replace_colors4[0] = 250/255;
replace_colors4[1] = 173/255;
replace_colors4[2] = 129/255;
#macro REPLACE_SKIN_DARK_ID replace_colors4

replace_colors5[0] = 158/255;
replace_colors5[1] = 31/255;
replace_colors5[2] = 35/255;
#macro REPLACE_PANTS_LIGHT_ID replace_colors5

replace_colors6[0] = 153/255;
replace_colors6[1] = 0;
replace_colors6[2] = 4/255;
#macro REPLACE_PANTS_DARK_ID replace_colors6

global.uniform_shirt_light = shader_get_uniform(shd_swapColors, "shirt_light");
global.uniform_shirt_dark = shader_get_uniform(shd_swapColors, "shirt_dark");
global.uniform_skin_light = shader_get_uniform(shd_swapColors, "skin_light");
global.uniform_skin_dark = shader_get_uniform(shd_swapColors, "skin_dark");
global.uniform_pants_light = shader_get_uniform(shd_swapColors, "pants_light");
global.uniform_pants_dark = shader_get_uniform(shd_swapColors, "pants_dark");

global.uniform_replace_shirt_light = shader_get_uniform(shd_swapColors, "replace_shirt_light");
global.uniform_replace_shirt_dark = shader_get_uniform(shd_swapColors, "replace_shirt_dark");
global.uniform_replace_skin_light = shader_get_uniform(shd_swapColors, "replace_skin_light");
global.uniform_replace_skin_dark = shader_get_uniform(shd_swapColors, "replace_skin_dark");
global.uniform_replace_pants_light = shader_get_uniform(shd_swapColors, "replace_pants_light");
global.uniform_replace_pants_dark = shader_get_uniform(shd_swapColors, "replace_pants_dark");

