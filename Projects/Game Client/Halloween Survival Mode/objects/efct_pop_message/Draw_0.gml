/// @description Insert description here
// You can write your code in this editor
var _pop = animcurve_channel_evaluate(global.pop_curve, pop_animate);
var _f = animcurve_channel_evaluate(global.fade_curve, fade_animate);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed_color(x, y, text, _pop*3, _pop*3, 0, color, color, color, color, 1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);