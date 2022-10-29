// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
#macro TIME floor(current_time/100)
#macro CENTER_X 4000
#macro CENTER_Y 4000
#macro WORLD_WIDTH 8000
#macro WORLD_HEIGHT 8000

//Popular equations:
#macro STAT_HP ceil(100*(entity_core.candies_stored[CANDY.red]*0.001))
#macro STAT_SPEED 2*(entity_core.candies_stored[CANDY.green]*0.001)
#macro STAT_ATTACK ceil(50*(entity_core.candies_stored[CANDY.blue]*0.001))
#macro STAT_PROJ_SPEED ceil(4*(entity_core.candies_stored[CANDY.black]*0.001))