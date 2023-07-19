/// @description Handle networking
var t = ds_map_find_value(async_load, "type");
switch(t)
{
	case network_type_data:
	{
		var b_data = async_load[? "buffer"];
		var data = buffer_read(b_data, buffer_text);
		
		//unpickle the data
		var _l = string_length(data)
		var temp_data = "";
		
		for (var i = 1; i <= _l; i++)
		{
			var _c = string_char_at(data, i);
			
			temp_data += _c;
			
			if (_c == "}")
			{
				handle_data(temp_data);
				temp_data = "";
			}
		}

		//buffer cleanup
		buffer_delete(b_data);
	}
	break;
}