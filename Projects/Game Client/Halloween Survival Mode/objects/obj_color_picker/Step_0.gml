/// @description Insert description here
// You can write your code in this editor
if (mouse_check_button(mb_left) && point_in_rectangle(mouse_x, mouse_y, x, y, x+186, y+224))
{
	hue = 255*((mouse_x-x)/186);
	sat = 255-255*((mouse_y-y)/224);
	
	arrow_x = mouse_x;
	arrow_y = mouse_y;
	
	scr_apply_hsv_color_to_skin(hue, sat, val, part);
}
else if (mouse_check_button(mb_left) && point_in_rectangle(mouse_x, mouse_y, x+199, y+1, x+212, y+223))
{
	show_debug_message(string(val));
	val = 255-255*((mouse_y-y)/222);
	bar_y = mouse_y;
	
	scr_apply_hsv_color_to_skin(hue, sat, val, part);
}