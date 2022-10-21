// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
#macro TIME floor(current_time/100)
#macro GUI_WIDTH display_get_gui_width()
#macro GUI_HEIGHT display_get_gui_height()
#macro MOUSE_X_IN_WORLD floor(mouse_x/32)*32 + 16
#macro MOUSE_Y_IN_WORLD floor(mouse_y/32)*32 + 16
#macro CENTER_X 1000
#macro CENTER_Y 1000

//Popular equations:
#macro STAT_HP ceil(100*(obj_core.candies_stored[CANDY.red]*0.001))
#macro STAT_SPEED 2*(obj_core.candies_stored[CANDY.green]*0.001)
#macro STAT_ATTACK ceil(50*(obj_core.candies_stored[CANDY.blue]*0.001))