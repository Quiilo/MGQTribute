event_inherited();
if (hp <= 0)
{

	if (image_index >= image_number - 1) image_speed = 0;
	else sprite_index = sprites.down;
}
else
{
	if (sprite_index == sprites.down) sprite_index = sprites.idle;
}