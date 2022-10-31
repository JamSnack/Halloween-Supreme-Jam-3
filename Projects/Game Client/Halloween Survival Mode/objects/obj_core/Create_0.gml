/// @description Insert description here
// You can write your code in this editor
draw_contents = 0;
range = 32;

builds_stored = array_create(BUILD.last, 0);
candies_stored = array_create(CANDY.last, 0);

surface_candy_pile = noone;
free_surface_candy_pile = false;

//request world update
var _d = ds_map_create();
_d[? "cmd"] = "request_core_update";
send_data(_d);

show_debug_message("Core exists");

create_pop_message(x, y-10, "Deposit treats here to gain bonus stats.", c_white, 0.001);