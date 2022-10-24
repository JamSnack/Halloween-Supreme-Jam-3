/// @description Insert description here
// You can write your code in this editor
if (regen_hp && hp < max_hp)
{
	hp += 0.02;
	
	if (update_block_during_regen_delay <= 0)
	{
		update_block();
		update_block_during_regen_delay = 60;
	}
	else update_block_during_regen_delay--;
	
	if (hp == max_hp)
	{
		regen_hp = false;
		update_block();
	}
}