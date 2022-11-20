/// @description Insert description here
// You can write your code in this editor
if (enemies_sent < total_enemies)
{
	if (instance_exists(entity_block))
	{
		instance_create_layer(irandom_range(x1, x2), irandom_range(y1, y2), "Instances", enemy_list[irandom(array_length(enemy_list)-1)]);
			
		enemies_sent++;
	}
	else total_enemies = -1;
}
else instance_destroy();