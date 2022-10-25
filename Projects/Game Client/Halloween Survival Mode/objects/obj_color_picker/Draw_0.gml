/// @description Insert description here
// You can write your code in this editor
draw_self();
draw_set_font(fnt_menu_text);
draw_text(x, y+280, "Hue: " + string(hue) + ", Sat: " + string(sat));

draw_sprite(spr_arrow_indicator, 0, arrow_x, arrow_y);

draw_sprite(spr_arrow_indicator, 0, x+(209+222)/2 - 8, bar_y);