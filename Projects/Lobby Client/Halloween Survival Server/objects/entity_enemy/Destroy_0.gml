/// @description Insert description here
// You can write your code in this editor
var _d = ds_map_create();
_d[? "cmd"] = "enemy_destroy";
_d[? "e_id"] = enemy_id;
_d[? "k_id"] = killer_id;
_d[? "candy"] = held_treat;
send_data(_d);