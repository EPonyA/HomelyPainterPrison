/// @description Draw terrain
if obj_editor_gui.mode = 0 {
	draw_surface(canSelect ? bakedStaircaseSelect : bakedStaircase, staircaseRasterX0, staircaseRasterY0);
} else if obj_editor_gui.mode = 1 {
	var zOff =  (zfloor - zcieling) * 20;
	
	if canSelect {
		layerColorShadow = obj_editor_gui.colOrangeShadow;
	} else {
		if zcieling > 0 {
			layerColorShadow = colDark[ abs( (zcieling-1) % 9) ];
		} else {
			layerColorShadow = c_gray;
		}
	}
	
	draw_set_color(layerColorShadow);
	draw_set_alpha(0.35);
	
	draw_triangle(x1,y1+zOff,x2,y2+zOff,x3,y3,false);
	draw_triangle(x3,y3,x2,y2+zOff,x4,y4,false);
	
	draw_set_alpha(1);
	
	draw_surface(canSelect ? bakedStaircaseWireframeSelect : bakedStaircaseWireframe, staircaseRasterX0, staircaseRasterY0);
} else if obj_editor_gui.mode = 2 {
	draw_surface(bakedStaircase, staircaseRasterX0, staircaseRasterY0);
}

/*
	draw_set_color(c_green);
	draw_rectangle(staircaseRasterX0,staircaseRasterY0,staircaseRasterX0+staircaseW,staircaseRasterY0+staircaseH,true);
	
	draw_set_color(c_black);
	draw_text(x1,y1,"1");
	draw_text(x2,y2,"2");
	draw_text(x3,y3,"3");
	draw_text(x4,y4,"4");
*/

/*
// Wireframe mode
#region

if obj_editor_gui.mode = 1 {
	if canSelect = false {
		layerColor = col[ abs( (zfloor-1) % 9) ];
	} else {
		layerColor = c_orange;
	}
	
	if zfloor > 0 {
		layerColorLine = make_color_rgb(color_get_red(layerColor)+30,color_get_green(layerColor)+30,color_get_blue(layerColor)+30);
		layerColorShadow = make_color_rgb(color_get_red(layerColor)-60,color_get_green(layerColor)-60,color_get_blue(layerColor)-60);
	} else {
		if canSelect = false {
			layerColorLine = c_white;
			layerColorShadow = c_gray;
		} else {
			layerColorLine = c_orange;
			layerColorShadow = c_red;
		}
	}
	draw_set_color(layerColorShadow);
	
	// Bottom surface
	draw_set_alpha(0.35);
	for (i = 0; i < width; i += 1) {
		if !mirror {
			draw_triangle(x+i*20,y-i*20+zfloor*20+20,x+i*20,y-i*20+zfloor*20,x+i*20+20,y-i*20+zfloor*20,false);
		} else {
			draw_triangle(x+width*20-i*20,y-i*20+zfloor*20+20,x+width*20-i*20-20,y-i*20+zfloor*20,x+width*20-i*20,y-i*20+zfloor*20,false);
		}
	}
	
	draw_set_alpha(1);
	draw_set_color(layerColorLine);
	
	// Top surface
	if !mirror {
		draw_line(x,y+height*20+zfloor*20,x+width*20,y+zfloor*20-width*20+20)
		draw_line(x,y+height*20+zfloor*20-1,x+width*20,y+zfloor*20-width*20+19)
			
		draw_line(x,y+height*20,x+width*20,y-width*20+20)
		draw_line(x,y+height*20-1,x+width*20,y-width*20+19)
	} else {
		draw_line(x,y+height*20+zfloor*20-width*20,x+width*20,y+zfloor*20+20)
		draw_line(x,y+height*20+zfloor*20-width*20-1,x+width*20,y+zfloor*20+19)
			
		draw_line(x,y+height*20-width*20,x+width*20,y+20)
		draw_line(x,y+height*20-width*20-1,x+width*20,y+19)
	}
	
	for (i = 0; i < width; i += 1) {
		if !mirror {
			draw_line(x+i*20,y-i*20,x+i*20,y-i*20+20);
			draw_line(x+i*20+1,y-i*20,x+i*20+1,y-i*20+20);
			
			draw_line(x+i*20,y-i*20,x+i*20+20,y-i*20);
			draw_line(x+i*20,y-i*20+1,x+i*20+20,y-i*20+1);
		} else {
			draw_line(x+i*20+20,y+i*20-width*20+20,x+i*20+20,y+i*20+40-width*20);
			draw_line(x+i*20+19,y+i*20-width*20+20,x+i*20+20,y+i*20+39-width*20);
			
			draw_line(x+i*20,y+i*20-width*20+20,x+i*20+20,y+i*20-width*20+20);
			draw_line(x+i*20,y+i*20-width*20+21,x+i*20+20,y+i*20-width*20+21);
		}
	}
	
	if !mirror {
		draw_line(x,y+height*20,x,y+height*20+zfloor*20);
		draw_line(x+1,y+height*20,x+1,y+height*20+zfloor*20);
	
		draw_line(x+width*20,y+height*20-width*20,x+width*20,y+zfloor*20+height*20-width*20);
		draw_line(x+width*20-1,y+height*20-width*20,x+width*20-1,y+zfloor*20+height*20-width*20);
	} else {
		draw_line(x+width*20,y+height*20,x+width*20,y+height*20+zfloor*20);
		draw_line(x+width*20-1,y+height*20,x+width*20-1,y+height*20+zfloor*20);
	
		draw_line(x,y+height*20-width*20,x,y+zfloor*20+height*20-width*20);
		draw_line(x+1,y+height*20-width*20,x+1,y+zfloor*20+height*20-width*20);
	}
}

#endregion

// Tile painting mode / Play testing mode
#region

if (obj_editor_gui.mode = 0 || obj_editor_gui.mode = 2 || obj_editor_gui.mode = 3 || obj_editor_gui.mode = 4) {
	// Draw walls
	for (j = heightIterate; j >= zfloor; j -= 1) {
		// Iterate across the z height
		for (i = 0; i < widthIterate; i += 1) {
			// Iterate across the width diagonally
			if obj_editor_gui.mode = 0 {
				alpha = 1;
				
				if canSelect = false {
					if zfloor > 0 {
						layerColor = col[ abs( (zfloor-1) % 9 ) ];
					} else {
						layerColor = c_white;
					}
				} else {
					layerColor = c_orange;
				}
			} else {
				//alpha = 0.2;
				layerColor = c_white;
			}
			draw_sprite_part_ext(sprMaterial,0,tileArrayDrawX[i,j],tileArrayDrawY[i,j],20,20,x+(i-1)*20,y+(zfloor-zcieling)*20-(j)*20,1,1,layerColor,alpha);
		}
	}
}

#endregion

*/
