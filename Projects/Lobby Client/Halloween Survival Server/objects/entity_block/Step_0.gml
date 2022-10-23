/// @description Insert description here
// You can write your code in this editor
if (regen_hp && hp <= max_hp)
{
	hp += 0.01;
	update_block();
	
	if (hp == max_hp)
		regen_hp = false;
}