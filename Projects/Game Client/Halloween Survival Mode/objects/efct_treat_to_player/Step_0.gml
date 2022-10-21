/// @description
if (target == obj_player)
{
	target_x = obj_player.x;
	target_y = obj_player.y;
	
	if (instance_exists(obj_core) && point_distance(obj_player.x, obj_player.y, obj_core.x, obj_core.y) <= 128)
	{
		target = noone;
		target_x = obj_core.x;
		target_y = obj_core.y;
	}
}


if (point_distance(x, y, target_x, target_y) <= 20)
	instance_destroy();
	
rate += 0.05;

var x_dir = sign(target_x - x);
var y_dir = sign(target_y - y);


x_speed = approach(x_speed, x_dir*10, rate);
y_speed = approach(y_speed, y_dir*10, rate);

x += x_speed;
y += y_speed;

image_angle += (4 + (x_speed * x_dir) * (y_speed * y_dir));