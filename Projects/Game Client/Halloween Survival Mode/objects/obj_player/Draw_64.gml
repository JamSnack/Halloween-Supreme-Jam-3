/// @description
//Drawp HP Vial
draw_sprite(spr_ui_health_vial, 0, 10, 5);
draw_set_font(fnt_default);
draw_text(40, 23, string(hp) + "\n\n\n\n" + string(max_hp) );