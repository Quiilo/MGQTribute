right_key = keyboard_check(vk_right);
left_key = keyboard_check(vk_left);
up_key = keyboard_check(vk_up);
down_key = keyboard_check(vk_down);


//movement code
xspd = (right_key - left_key) * mov_spd;
yspd = (down_key - up_key) * mov_spd;

//collision code
if place_meeting(x + xspd, y, obj_wall) == true
{
  xspd = 0;	
}
if place_meeting(x, y + yspd, obj_wall) == true
{
  yspd = 0;	
}

x += xspd;
y += yspd;


//set sprite
if xspd > 0 {face = RIGHT;image_xscale = 1}
if xspd < 0 {face = LEFT; image_xscale = -1}
	
	
sprite_index = sprite[face];

if xspd == 0 && yspd == 0
{
 image_index = 0;	
}