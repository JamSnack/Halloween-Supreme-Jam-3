/// @description Insert description here
// You can write your code in this editor
if (total_blocks > 0)
{
	if (instance_exists(entity_block))
	{
		with instance_find(entity_block, total_blocks-1)
			send_new_block_to_player(other.receiving_player);
			
		total_blocks--;	
	}
	else total_blocks = 0;
}
else instance_destroy();

//TODO: Remove else instance_destroy above and make this object send enemies as well.