/// @description Insert description here
// You can write your code in this editor
var _range = 0.5;
var x_speed = max(draw_x - x, x - draw_x);
var y_speed = max(draw_y - y, y - draw_y);

if (draw_x != x && x_speed > _range || draw_y != y && y_speed > _range)
{
	//calculate if speed is great enough to be running
	if (x_speed > 2 || y_speed > 2)
		sprite_index = run_sprite;
	else
		sprite_index = walk_sprite;	
	
	//animate
	anim_index += max(x_speed, y_speed)/16;
		
} else sprite_index = idle_sprite;

//Physically move the object
draw_x = lerp(draw_x, x, interpolation_rate);
draw_y = lerp(draw_y, y, interpolation_rate);

//Pass anim_index into image_index
image_index = anim_index;

//Manage despawn timer
if (despawn_timer > 0)
{
	despawn_timer--;
	
	if (despawn_timer <= 0)
		instance_destroy();
}	