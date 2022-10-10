function get_next_id()
{
	global.next_id += 1;
	
	if (global.next_id > 9999)
		global.next_id = 0;
	
	return global.next_id;
}