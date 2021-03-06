function scr_collision_vector() {
	var trgColl;
	var normalAngleListX;
	var normalAngleListY;
	var intersectionCount = 0;
	var intersectionX;
	var intersectionY;
	var summedAngleX = 0;
	var summedAngleY = 0;
	var projectDir;

	// Loop through collision vectors
#region

	for (var i = 0; i < instance_number(obj_solid_parent); i++) {
		trgColl = instance_find(obj_solid_parent, i).id;
		trgColl.DRAWC = 0;
	
		if point_distance(x, y, trgColl.collX1 + (trgColl.collX2 - trgColl.collX1)/2, trgColl.collY1 + (trgColl.collY2 - trgColl.collY1)/2) < point_distance(trgColl.collX1,trgColl.collY1,trgColl.collX2,trgColl.collY2) + max(collisionCoeffX, collisionCoeffY) {
			for (var j = 0; j <= 1; j++) {
				if trgColl.projectState != 2 {
					if j = 1 { break; }
					projectDir = trgColl.projectState;
				} else {
					projectDir = j;
				}
			
				// Bresnham line inteprolation across the collision vector.
				var x1 = trgColl.collX1;
				var y1 = trgColl.collY1;
				var x2 = trgColl.collX2;
				var y2 = trgColl.collY2;
			
				var ang = point_direction(x1, y1, x2, y2);
				var normalAng = (ang - 90 + 360) % 360;
			
				if projectDir = 0 {
					x1 -= round(lengthdir_x(collisionCoeffX, normalAng + 45));
					y1 -= round(lengthdir_y(collisionCoeffY, normalAng + 45));
					x2 -= round(lengthdir_x(collisionCoeffX, normalAng - 45));
					y2 -= round(lengthdir_y(collisionCoeffY, normalAng - 45));
				} else if projectDir = 1 {
					x1 += round(lengthdir_x(collisionCoeffX, normalAng - 45));
					y1 += round(lengthdir_y(collisionCoeffY, normalAng - 45));
					x2 += round(lengthdir_x(collisionCoeffX, normalAng + 45));
					y2 += round(lengthdir_y(collisionCoeffY, normalAng + 45));
				}
			
				var x0 = x1;
				var y0 = y1;
			
				var dx = abs(x2 - x1);
				var sx = (x1 < x2) ? 1 : -1;
				var dy = -abs(y2 - y1);
				var sy = (y1 < y2) ? 1 : -1;
				var err = dx + dy;
				var e2;
			
				var leftward;
				if x1 > x2 { leftward = 1; }
				else if x1 < x2 { leftward = 0; }
				else { leftward = 2; }
			
				var upward;
				if y1 > y2 { upward = 1; }
				else if y1 < y2 { upward = 0; }
				else { upward = 2; }
			
				var breakBool = false;
			
				// Loop across line.
				while (true) {
					// Collision.
					with trgColl {
						DRAWC++;
						DRAWX[DRAWC] = x1;
						DRAWY[DRAWC] = y1;
					
						if collision_point(x1, y1, other.id, false, true)
						//if floor(x) = x1 && floor(y) = y1
						{
							// Assigned here, because this is more precise than the actor's X or Y.
							intersectionX = x1;
							intersectionY = y1;
						
							if (other.c_hspeed != 0 || other.c_vspeed != 0) {
								//var VAx = other.c_hspeed;
								//var VAy = other.c_vspeed;
								var VNx = y2 - y0;
								var VNy = x0 - x2;
							
								// Prevent walking directly into a vector.
								var testAngle = ( point_direction(0, 0, other.c_hspeed, other.c_vspeed) - point_direction(x0, y0, x2, y2) + 360 ) % 360;
								if (testAngle = 0) || (testAngle = 180) {
									normalAngleListX[intersectionCount] = lengthdir_x(10, testAngle);
									normalAngleListY[intersectionCount] = lengthdir_y(10, testAngle);
								
									break;
								}
							
								// Normalize VN
								/*var vDist = point_distance(0, 0, VNx, VNy);
							
								var VNHatx = VNx / vDist;
								var VNHaty = VNy / vDist;
							
								normalAngleListX[intersectionCount] = VNHatx;
								normalAngleListY[intersectionCount] = VNHaty;*/
								normalAngleListX[intersectionCount] = VNx;
								normalAngleListY[intersectionCount] = VNy;
							
								intersectionCount++;
								breakBool = true;
							}
						}
					}
				
					if breakBool {
						break;
					}
				
					// Break at the end of the line.
					if
					(  ( x1 >= x2 && leftward = 0) || ( x1 <= x2 && leftward = 1 ) || ( x1 = x2 && leftward = 2 )  )
					&& (  ( y1 >= y2 && upward = 0) || ( y1 <= y2 && upward = 1 ) || (y1 = y2 && upward = 2 )  )
					{
						break;
					}
				
					// Iterate across the line.
					e2 = 2 * err;
			
					if e2 >= dy {
						err += dy;
						x1 += sx;
					}
				
					if e2 <= dx {
						err += dx;
						y1 += sy;
					}
				}
			}
		}
	}

#endregion

	// Sum angles
	if intersectionCount > 0 {
		// Sum normal angles.
		for (i = 0; i < intersectionCount; i++) {
			summedAngleX += normalAngleListX[i];
			summedAngleY += normalAngleListY[i];
		}
	
		// Normalize summed angle.
		var vDist = point_distance(0, 0, summedAngleX, summedAngleY);
	
		var VNHatx = summedAngleX / vDist;
		var VNHaty = summedAngleY / vDist;
	
		// Find dot product
		var dotProduct = (c_hspeed * VNHatx) + (c_vspeed * VNHaty);
		var VXx =  dotProduct * VNHatx * 2;
		var VXy =  dotProduct * VNHaty * 2;
	
		var xOff = c_hspeed - VXx;
		var yOff = c_vspeed - VXy;
	
		// Normalize actor displacement.
		/*vDist = point_distance(0, 0, xOff, yOff);
		xOff /= vDist;
		yOff /= vDist;*/
	
		while collision_point(intersectionX, intersectionY, self, false, false)
		//while floor(x) = intersectionX && floor(y) = intersectionY
		{
			x += xOff;
			y += yOff;
		}
	
		x = round(x);
		y = round(y);
		DRAWANGLE = point_direction(0, 0, VXx, VXy);
	}



}
