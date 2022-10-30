/// @description Insert description here
// You can write your code in this editor
if (instance_exists(follow_this))
{
	x = lerp(x, follow_this.draw_x, 0.1);
	y = lerp(y, follow_this.draw_y, 0.1);
}

//update view
camera_set_view_pos(view_get_camera(0), x - global.display_width/2, y - global.display_height/2);