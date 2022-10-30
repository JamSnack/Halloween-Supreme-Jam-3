/// @description Insert description here
// You can write your code in this editor
draw_x = x;
draw_y = y;
interpolation_rate = 0.1;
anim_index = 0;

despawn_timer_set = room_speed*10;
despawn_timer = despawn_timer_set;

idle_sprite = sprite_index;
walk_sprite = sprite_index;
run_sprite = sprite_index;

damage_animation = 0;

use_anim_index = true;
use_animation_prediction = true;