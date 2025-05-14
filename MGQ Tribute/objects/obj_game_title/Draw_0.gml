draw_set_font(spr_main_font);
height = string_height("Questy's quest") + op_border*2;
draw_set_valign(fa_top);
draw_set_halign(fa_left);

draw_sprite_ext(sprite_index, image_index, x - 3, y - 3, width/sprite_width, height/sprite_height, 0, c_white, 1);


var _c = c_white;

//draw_text(x + op_border, y + op_border + op_space, "Questy's quest");
draw_text_color(x + op_border, y, "Questy's quest", _c, _c, _c, _c, 1);