/// @description
if (point_distance(x, y, target_x, target_y) <= 60)
{
	var _t = instance_create_layer(target_x, target_y, "Instances", object);
	_t.tile_id = object_id;
	_t.max_hp = max_hp;
	_t.hp = hp;
	instance_destroy();
	
	//request tile update
	var _d = ds_map_create();
	_d[? "cmd"] = "request_tile_update";
	_d[? "t_id"] = object_id;
	send_data(_d);
}

x_speed = approach(x_speed, sign(target_x - x)*20, 10);
y_speed = approach(y_speed, sign(target_y - y)*20, 10);

x += x_speed;
y += y_speed;

image_angle += (2 + x_speed*y_speed);