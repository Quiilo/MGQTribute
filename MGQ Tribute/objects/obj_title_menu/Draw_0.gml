//menu background
draw_set_font(spr_main_font);
height = op_border*2 + string_height(options[0,0]) + (op_length - 1)*op_space;


draw_sprite_ext(sprite_index, image_index, x, y, width/sprite_width, height/sprite_height, 0, c_white, 1);

// buttons

draw_set_valign(fa_top);
draw_set_halign(fa_left);

for (var i = 0; i < op_length; i++)
{
	var _c = c_white;
	if pos == i {_c = c_yellow};
   draw_text_color(x + op_border, y + op_border + op_space * i, options[menu_level,i], _c, _c, _c, _c, 1);
}