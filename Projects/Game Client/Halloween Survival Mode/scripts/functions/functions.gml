// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function approach(value, target, rate)
{
	if (argument0 < argument1)
	    return min(argument0 + argument2, argument1); 
	else
	    return max(argument0 - argument2, argument1);	
}

function scr_select_projectile_sprites(_index)
{
	switch (_index)
	{
		case PROJECTILE.egg: { return spr_projectile_egg; } break;
		case PROJECTILE.wave: { return spr_projectile_wave; } break;
		case PROJECTILE.wind: { return spr_projectile_wind; } break;
		default: { return spr_projectile; } break;
	}
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
		}
		break;
		
		case ENEMY.ocean_node:
		{
			walk_sprite = spr_ocean_nodes;
			run_sprite = spr_ocean_nodes;
			idle_sprite = spr_ocean_nodes;
			use_anim_index = false;
			
			sprite_index = spr_ocean_nodes;
			image_index = irandom(image_number);
			image_xscale = choose(1, -1);
		}
		break;
		
		case ENEMY.rock:
		{
			walk_sprite = spr_rock;
			run_sprite = spr_rock;
			idle_sprite = spr_rock;
			use_anim_index = false;
			
			sprite_index = spr_rock;
			image_index = irandom(image_number);
			image_xscale = choose(1, -1);
		}
		break;
		
		case ENEMY.star:
		{
			walk_sprite = spr_star;
			run_sprite = spr_star;
			idle_sprite = spr_star;
			use_anim_index = false;
			
			sprite_index = spr_star;
			image_index = irandom(image_number);
			image_xscale = choose(1, -1);
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
		
		case ENEMY.poultrygeist:
		{
			walk_sprite = spr_poultrygeist;
			run_sprite = spr_poultrygeist;
			idle_sprite = spr_poultrygeist;
			use_anim_index = true;
		}
		break;
		
		case ENEMY.tender_spirit:
		{
			walk_sprite = spr_tender_spirit;
			run_sprite = spr_tender_spirit;
			idle_sprite = spr_tender_spirit;
			use_anim_index = true;
		}
		break;
		
		case ENEMY.skeleton_crab:
		{
			walk_sprite = spr_skeleton_crab;
			run_sprite = spr_skeleton_crab;
			idle_sprite = spr_skeleton_crab;
			use_anim_index = true;
		}
		break;
		
		case ENEMY.skeleton_crab_minion:
		{
			walk_sprite = spr_skeleton_crab_minion;
			run_sprite = spr_skeleton_crab_minion;
			idle_sprite = spr_skeleton_crab_minion;
			use_anim_index = true;
		}
		break;
		
		case ENEMY.halloween_ham:
		{
			walk_sprite = spr_halloween_ham;
			run_sprite = spr_halloween_ham;
			idle_sprite = spr_halloween_ham;
			use_anim_index = true;
		}
		break;
		
		case ENEMY.ham_jumpkin:
		{
			walk_sprite = spr_ham_jumpkin;
			run_sprite = spr_ham_jumpkin;
			idle_sprite = spr_ham_jumpkin;
			use_anim_index = true;
		}
		break;
		
		case ENEMY.ghost:
		{
			walk_sprite = spr_ghost;
			run_sprite = spr_ghost;
			idle_sprite = spr_ghost;
			use_anim_index = true;
		}
		break;
		
		case ENEMY.gravestone:
		{
			walk_sprite = spr_gravestone;
			run_sprite = spr_gravestone;
			idle_sprite = spr_gravestone;
			use_anim_index = true;
		}
		break;
		
		case ENEMY.imp:
		{
			walk_sprite = spr_imp;
			run_sprite = spr_imp;
			idle_sprite = spr_imp;
			use_anim_index = true;
		}
		break;
	}
}

function scr_get_enemy_name(_index)
{
	switch (_index)
	{
		case ENEMY.greenthin: { return "Greenthin"; } break;
		case ENEMY.jumpkin: { return "Jumpkin"; } break;
		case ENEMY.pigyamo: { return "Pigyamo"; } break;
		case ENEMY.weed: { return "Weed"; } break;
		case ENEMY.pumpkin: { return "Pumpkin"; } break;
		case ENEMY.gold_jumpkin: { return "Golden Jumpkin"; } break;
		case ENEMY.troopie: { return "Troopie"; } break;
		case ENEMY.zombie: { return "Zombie"; } break;
		case ENEMY.scarecrow: { return "Scarecrow"; } break;
		case ENEMY.poultrygeist: { return "Poultrygeist"; } break;
		case ENEMY.tender_spirit: { return "Tender Spirit"; } break;
		case ENEMY.skeleton_crab: { return "Skeleton Crab"; } break; 
		case ENEMY.skeleton_crab_minion: { return "Crab Minion"; } break;
		case ENEMY.halloween_ham: { return "The Halloween Ham"; } break;
		case ENEMY.ham_jumpkin: { return "Ham-Flavoured Jumpkin"; } break;
		case ENEMY.ocean_node: { return "Ocean Node"; } break;
		case ENEMY.rock: { return "Stone"; } break;
		case ENEMY.star: { return "Star"; } break;
		case ENEMY.ghost: { return "Ghost"; } break;
		case ENEMY.imp: { return "Imp"; } break;
		case ENEMY.gravestone: { return "Gravestone"; } break;
	}
}


function create_pop_message(x, y, text, color, rate = 0.01)
{
	/*var _cx = camera_get_view_x(view_camera[0]);
	var _cy = camera_get_view_y(view_camera[0]);
			
	if (x > _cx && x < _cx + 1366)
		return;
					
	if (y > _cy && y < _cy + 768)
		return;*/
	var _i = instance_create_layer(x, y, "Instances", efct_pop_message);
	_i.text = string(text);
	_i.color = color;
	_i.rate = rate;
}

function execute_lobby()
{
	var _f = working_directory + "Lobby\\Halloween Survival Server.exe"
	//show_message(_f + "\nExists: "+ string( file_exists(_f) ) );
	execute_shell_simple(_f);
}

function scr_shader_swapColors_set_uniforms(shirt_light, shirt_dark, skin_light, skin_dark, pants_light, pants_dark)
{
	shader_set_uniform_f_array(global.uniform_shirt_light, SHIRT_LIGHT_ID);
	shader_set_uniform_f_array(global.uniform_shirt_dark, SHIRT_DARK_ID);
	shader_set_uniform_f_array(global.uniform_skin_light, SKIN_LIGHT_ID);
	shader_set_uniform_f_array(global.uniform_skin_dark, SKIN_DARK_ID);
	shader_set_uniform_f_array(global.uniform_pants_light, PANTS_LIGHT_ID);
	shader_set_uniform_f_array(global.uniform_pants_dark, PANTS_DARK_ID);
		
	shader_set_uniform_f_array(global.uniform_replace_shirt_light, shirt_light);
	shader_set_uniform_f_array(global.uniform_replace_shirt_dark, shirt_dark);
	shader_set_uniform_f_array(global.uniform_replace_skin_light, skin_light);
	shader_set_uniform_f_array(global.uniform_replace_skin_dark, skin_dark);
	shader_set_uniform_f_array(global.uniform_replace_pants_light, pants_light);
	shader_set_uniform_f_array(global.uniform_replace_pants_dark, pants_dark);	
}

function scr_apply_hsv_color_to_skin(hue, sat, val, part)
{
	color = make_color_hsv(hue, sat, val);
	
	switch (part)
	{
		case "shirt":
		{
			REPLACE_SHIRT_LIGHT_ID[0] = color_get_red(color)/255;
			REPLACE_SHIRT_LIGHT_ID[1] = color_get_green(color)/255;
			REPLACE_SHIRT_LIGHT_ID[2] = color_get_blue(color)/255;
	
			REPLACE_SHIRT_DARK_ID[0] = -0.25 + color_get_red(color)/255;
			REPLACE_SHIRT_DARK_ID[1] = -0.25 + color_get_green(color)/255;
			REPLACE_SHIRT_DARK_ID[2] = -0.25 + color_get_blue(color)/255;
		}
		break;
		
		case "pants":
		{
			REPLACE_PANTS_LIGHT_ID[0] = color_get_red(color)/255;
			REPLACE_PANTS_LIGHT_ID[1] = color_get_green(color)/255;
			REPLACE_PANTS_LIGHT_ID[2] = color_get_blue(color)/255;
	
			REPLACE_PANTS_DARK_ID[0] = -0.15 + color_get_red(color)/255;
			REPLACE_PANTS_DARK_ID[1] = -0.15 + color_get_green(color)/255;
			REPLACE_PANTS_DARK_ID[2] = -0.15 + color_get_blue(color)/255;
		}
		break;
		
		case "skin":
		{
			REPLACE_SKIN_LIGHT_ID[0] = color_get_red(color)/255;
			REPLACE_SKIN_LIGHT_ID[1] = color_get_green(color)/255;
			REPLACE_SKIN_LIGHT_ID[2] = color_get_blue(color)/255;
	
			REPLACE_SKIN_DARK_ID[0] = -0.15 + color_get_red(color)/255;
			REPLACE_SKIN_DARK_ID[1] = -0.15 + color_get_green(color)/255;
			REPLACE_SKIN_DARK_ID[2] = -0.15 + color_get_blue(color)/255;
		}
		break;
	}
}

function scr_get_block_object_from_type(type)
{
	switch (type)
	{
		case BUILD.block:		{ return obj_block_entity;		 } break;
		case BUILD.door:		{ return obj_block_door_entity;  } break;
		case BUILD.glass:		{ return obj_block_glass_entity; } break;
		case BUILD.false_block:	{ return obj_false_block;		 } break;
		case BUILD.last:		{ return obj_core;				 } break;
		default:				{ return undefined;				 } break;
	}
}

function play_sound(sound, priority, loops, interrupts_others, x = noone, y = noone)
{
	if (interrupts_others && audio_exists(sound))
			audio_stop_sound(sound);
	
	if (x == noone && y == noone)
		audio_play_sound(sound, priority, loops);
	else
		audio_play_sound_at(sound, x, y, 0, 150, 600, 1.5, loops, priority);
}