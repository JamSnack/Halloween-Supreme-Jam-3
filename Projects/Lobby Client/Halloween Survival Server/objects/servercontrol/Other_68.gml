/// @description Insert description here
/// @description Handle networking
var t = ds_map_find_value(async_load, "type");
switch(t)
{
	case network_type_data:
	{
		var b_data = async_load[? "buffer"];
		var data = buffer_read(b_data, buffer_string);
		handle_data(data);
		
		//buffer cleanup
		buffer_delete(b_data);
	}
	break;
}