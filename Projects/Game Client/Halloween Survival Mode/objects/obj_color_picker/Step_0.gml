/// @description Insert description here
// You can write your code in this editor
var x_width = 186*image_xscale;
var y_height = 224*image_yscale;

if (mouse_check_button(mb_left) && point_in_rectangle(mouse_x, mouse_y, x, y, x+x_width, y+y_height))
{
	hue = 255*((mouse_x-x)/x_width);
	sat = 255-255*((mouse_y-y)/y_height);
	
	arrow_x = mouse_x;
	arrow_y = mouse_y;
	
	scr_apply_hsv_color_to_skin(hue, sat, val, part);
}
else if (mouse_check_button(mb_left) && point_in_rectangle(mouse_x, mouse_y, x+199*image_xscale, y+1*image_yscale, x+212*image_xscale, y+223*image_yscale))
{
	val = 255-255*((mouse_y-y)/222*image_yscale);
	bar_y = mouse_y;
	
	scr_apply_hsv_color_to_skin(hue, sat, val, part);
}