/// @description
if (point_distance(x, y, target_x, target_y) <= rate)
{
	var _t = instance_create_layer(target_x, target_y, "Instances", object);
	_t.tile_id = object_id;
	_t.max_hp = max_hp;
	_t.hp = hp;
	
	//destroy
	instance_destroy();
	
	//request tile update
	request_tile_update(object_id);
}

rate += 1;

x_speed = approach(x_speed, sign(target_x - x)*rate, rate);
y_speed = approach(y_speed, sign(target_y - y)*rate, rate);

x += x_speed;
y += y_speed;

image_angle += (2 + x_speed*y_speed);