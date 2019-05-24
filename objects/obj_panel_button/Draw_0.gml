/// @description 
if sprWidth != -1 {
	// Button
	draw_set_color(col[0]); // Inside fill
	draw_rectangle(x+3,y+1,x+sprWidth-2,y+27,false);
	
	draw_set_color(col[1]); // Gray outside outline
	draw_rectangle(x+2,y,x+sprWidth-1,y,false);
	draw_rectangle(x+2,y+29,x+sprWidth-1,y+29,false);
	draw_rectangle(x+1,y+1,x+1,y+28,false);
	draw_rectangle(x+sprWidth,y+1,x+sprWidth,y+28,false);
	
	draw_set_color(col[2]); // Dark inside outline
	draw_rectangle(x+3,y+1,x+sprWidth-2,y+1,false);
	draw_rectangle(x+3,y+28,x+sprWidth-2,y+28,false);
	draw_rectangle(x+2,y+2,x+2,y+27,false);
	draw_rectangle(x+sprWidth-1,y+2,x+sprWidth-1,y+27,false);
	
	draw_sprite(spr_button_corner,imgIndex,x+3,y+2); // Corners
	draw_sprite_ext(spr_button_corner,imgIndex,x+3,y+28,1,-1,0,c_white,1);
	draw_sprite_ext(spr_button_corner,imgIndex,x+sprWidth-1,y+2,-1,1,0,c_white,1);
	draw_sprite_ext(spr_button_corner,imgIndex,x+sprWidth-1,y+28,-1,-1,0,c_white,1);
	
	draw_set_color(col[3]); // Text label
	draw_set_font(font);
	draw_text_transformed(x+6,y+7,label,2,2,0);
	
	if buttonType = 0 {
		// Icon display
		draw_set_color(perimeterCol);
		draw_rectangle(x+sprWidth+6,y-1,x+sprWidth+32,y-1,false);
		draw_rectangle(x+sprWidth+6,y+30,x+sprWidth+32,y+30,false);
		draw_rectangle(x+sprWidth+3,y,x+sprWidth+3,y+29,false);
		draw_rectangle(x+sprWidth+34,y,x+sprWidth+34,y+29,false);
		
		draw_set_color(perimeterInsideCol);
		draw_rectangle(x+sprWidth+4,y,x+sprWidth+33,y+29,false);
		
		draw_set_color(graphicFillOutsideCol);
		draw_rectangle(x+sprWidth+5,y+1,x+sprWidth+32,y+28,false);
		
		draw_set_color(graphicFillInsideCol);
		draw_rectangle(x+sprWidth+6,y+2,x+sprWidth+31,y+27,false);
		
		draw_sprite(spr_preview_corner,0,x+sprWidth+6,y+2); // Corners
		draw_sprite_ext(spr_preview_corner,0,x+sprWidth+32,y+2,-1,1,0,c_white,1);
		draw_sprite_ext(spr_preview_corner,0,x+sprWidth+6,y+28,1,-1,0,c_white,1);
		draw_sprite_ext(spr_preview_corner,0,x+sprWidth+32,y+28,-1,-1,0,c_white,1);
		
		draw_sprite(sprite_index,0,x+sprWidth+19,y+27);
	}
	
	if buttonType = 1 {
		// Wheel graphic
		if angle != -1 {
			draw_set_color(perimeterCol);
			draw_line(x+sprWidth+4+sprite_width/2,y-1+sprite_height/2,x+sprWidth+4+sprite_width/2+lengthdir_x(14,angle),y-1+sprite_height/2+lengthdir_y(14,angle));
		}
		
		draw_sprite(sprite_index,1,x+sprWidth+2+sprite_width/2,y-1+sprite_height/2);
		
		if angle != -1 {
			draw_set_color(graphicCol2);
			draw_line(x+sprWidth+3+sprite_width/2,y-1+sprite_height/2,x+sprWidth+3+sprite_width/2+lengthdir_x(15,angle),y-1+sprite_height/2+lengthdir_y(15,angle));
			draw_set_color(graphicCol1);
			draw_line(x+sprWidth+2+sprite_width/2,y-1+sprite_height/2,x+sprWidth+2+sprite_width/2+lengthdir_x(15,angle),y-1+sprite_height/2+lengthdir_y(15,angle));
		}
		
		draw_sprite(sprite_index,0,x+sprWidth+2+sprite_width/2,y-1+sprite_height/2);
	}
	
	if buttonType = 2 {
		// Value display
		draw_set_color(perimeterCol);
		draw_rectangle(x+sprWidth+6,y-1,x+sprWidth+6+valueLength,y-1,false);
		draw_rectangle(x+sprWidth+6,y+30,x+sprWidth+6+valueLength,y+30,false);
		draw_rectangle(x+sprWidth+3,y,x+sprWidth+3,y+29,false);
		draw_rectangle(x+sprWidth+8+valueLength,y,x+sprWidth+8+valueLength,y+29,false);
		
		draw_set_color(perimeterInsideCol);
		draw_rectangle(x+sprWidth+4,y,x+sprWidth+7+valueLength,y+29,false);
		
		draw_set_color(graphicFillOutsideCol);
		draw_rectangle(x+sprWidth+5,y+1,x+sprWidth+6+valueLength,y+28,false);
		
		draw_set_color(graphicFillInsideCol);
		draw_rectangle(x+sprWidth+6,y+2,x+sprWidth+5+valueLength,y+27,false);
		
		draw_sprite(spr_preview_corner,0,x+sprWidth+6,y+2); // Corners
		draw_sprite_ext(spr_preview_corner,0,x+sprWidth+6+valueLength,y+2,-1,1,0,c_white,1);
		draw_sprite_ext(spr_preview_corner,0,x+sprWidth+6,y+28,1,-1,0,c_white,1);
		draw_sprite_ext(spr_preview_corner,0,x+sprWidth+6+valueLength,y+28,-1,-1,0,c_white,1);
		
		draw_set_font(obj_editor_gui.font);
		draw_set_color(col[3]);
		draw_text_transformed(x+sprWidth+7,y+7,arbitraryVal,2,2,0);
	}
}
