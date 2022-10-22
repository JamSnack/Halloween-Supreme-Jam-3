/// @description Insert description here
// You can write your code in this editor
lifetime--;

//Collision
//- block collision
var colliding_with_block = false;

if (instance_exists(obj_block_entity))
{
	var col = collision_point(x, y, obj_block_entity, false, true);
	
	if (col != noone)
	{
		if (col.object_index != obj_block_glass_entity)
			colliding_with_block = true;
	}
}

//- enemy collision
if (instance_exists(obj_enemy_entity))
{
	var col = collision_point(x, y, obj_enemy_entity, false, true);
	
	if (col != noone)
		colliding_with_block = true;
}

//Kill
if (lifetime <= 0 || colliding_with_block)
	instance_destroy();