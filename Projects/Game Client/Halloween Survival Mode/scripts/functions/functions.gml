// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function approach(value, target, rate)
{
	if (argument0 < argument1)
	    return min(argument0 + argument2, argument1); 
	else
	    return max(argument0 - argument2, argument1);	
}

function scr_select_enemy_sprites(_index)
{
	switch (_index)
	{
		case ENEMY.greenthin:
		{
			walk_sprite = spr_greenthin;
			run_sprite = spr_greenthin;
			idle_sprite = spr_greenthin;
			use_anim_index = false;
		}
		break;
		
		case ENEMY.jumpkin:
		{
			walk_sprite = spr_jumpkin;
			run_sprite = spr_jumpkin;
			idle_sprite = spr_jumpkin;
			use_anim_index = true;
		}
		break;
		
		case ENEMY.pigyamo:
		{
			walk_sprite = spr_pigyamo;
			run_sprite = spr_pigyamo;
			idle_sprite = spr_pigyamo;
			use_anim_index = false;
		}
		break;
		
		case ENEMY.weed:
		{
			walk_sprite = spr_weed;
			run_sprite = spr_weed;
			idle_sprite = spr_weed;
			use_anim_index = false;
			
			sprite_index = spr_weed;
			image_index = irandom(image_number);
			image_xscale = choose(1, -1);
			
			despawn_timer = -1;
		}
		break;
		
		case ENEMY.pumpkin:
		{
			walk_sprite = spr_pumpkin;
			run_sprite = spr_pumpkin;
			idle_sprite = spr_pumpkin;
			use_anim_index = false;
			
			sprite_index = spr_pumpkin;
			image_index = irandom(image_number);
			image_xscale = choose(1, -1);
			
			despawn_timer = -1;
		}
		break;
		
		case ENEMY.gold_jumpkin:
		{
			walk_sprite = spr_gold_jumpkin;
			run_sprite = spr_gold_jumpkin;
			idle_sprite = spr_gold_jumpkin;
			use_anim_index = true;
		}
		break;
		
		case ENEMY.troopie:
		{
			walk_sprite = spr_troopie;
			run_sprite = spr_troopie;
			idle_sprite = spr_troopie;
			use_anim_index = true;
		}
		break;
		
		case ENEMY.zombie:
		{
			walk_sprite = spr_zombie;
			run_sprite = spr_zombie;
			idle_sprite = spr_zombie;
			use_anim_index = true;
		}
		break;
		
		case ENEMY.scarecrow:
		{
			walk_sprite = spr_scarecrow;
			run_sprite = spr_scarecrow;
			idle_sprite = spr_scarecrow;
			use_anim_index = true;
		}
		break;
	}
}


function create_pop_message(x, y, text, color)
{
	var _i = instance_create_layer(x, y, "Instances", efct_pop_message);
	_i.text = string(text);
	_i.color = color;
}
