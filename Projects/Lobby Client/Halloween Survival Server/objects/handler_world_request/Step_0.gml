/// @description Insert description here
// You can write your code in this editor
if (blocks_sent < total_blocks)
{
	if (instance_exists(entity_block))
	{
		with instance_find(entity_block, blocks_sent)
			send_new_block_to_player(other.receiving_player);
			
		blocks_sent++;	
	}
	else total_blocks = -1;
}
else instance_destroy();

//TODO: Remove else instance_destroy above and make this object send enemies as well.