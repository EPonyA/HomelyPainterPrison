/// @description Insert description here
draw_set_color(make_color_rgb(252,244,122));
draw_rectangle(x,y - zfloor*20,x,y,false);

if gone {
	draw_line(originX[j-1],originY[j-1] - zfloor*20,x,y - zfloor*20);
	draw_sprite_ext(sprite_index,0,originX[j-1],originY[j-1] - zfloor*20,0.65,0.65,0,c_white,1);
}

draw_sprite(sprite_index,image_index,x,y);
draw_sprite(sprite_index,image_index,x,y - zfloor*20);

draw_set_color(c_white);
