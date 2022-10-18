function get_next_id()
{
	global.next_id += 1;
	
	if (global.next_id > 9999)
		global.next_id = 0;
	
	return global.next_id;
}

function approach(value, target, rate)
{
	if (argument0 < argument1)
	    return min(argument0 + argument2, argument1); 
	else
	    return max(argument0 - argument2, argument1);	
}