/// @description Delayed objects spawn
instance_create_layer(obj_camera_editor.x,obj_camera_editor.y,"Instances",obj_player_overworld);

with obj_trigger_cutscene_region_editor {
	// Region collision
	with instance_create_layer(x,y,"Instances",obj_trigger_cutscene_region_level) {
		x = other.x;
		y = other.y;
		image_xscale = other.width;
		image_yscale = other.height;
		zfloor = other.zfloor;
		rows = instance_number(obj_actor_parent);
		totalActions = other.totalActions;
		longestRowLength = other.longestRowLength;
		polygon = other.polygon;
		
		// Initialize ticks
		for (i = 0; i <= longestRowLength; i += 1) {
			for (j = 0; j < rows; j += 1) {
				actionInd[i,j] = -1; // Null action
				actorTxt[j] = other.actorTxt[j];
			}
		}
		
		for (i = 1; i <= totalActions; i += 1) {
			actionInd[other.actionTime[i],other.actionRowInd[i]] = other.actionInd[i]; // Action type
			actionTime[i] = other.actionTime[i]; // 1/10'th second tick
			
			// Walk action
			if actionInd[other.actionTime[i],other.actionRowInd[i]] = 0 {
				xNode[other.actionTime[i],other.actionRowInd[i]] = other.xNode[i];
				yNode[other.actionTime[i],other.actionRowInd[i]] = other.yNode[i];
				
				// Whether the actor continues walking afterwards
				endWalk[other.actionTime[i],other.actionRowInd[i]] = true;
				
				for (j = 0; j <= totalActions; j += 1) {
					if other.actionRowInd[j] = other.actionRowInd[i] {
						if other.actionInd[j] = 0 {
							if other.actionTime[j] > other.actionTime[i] {
								if abs(other.actionTime[i] - other.actionTime[j]) <= 4 {
									endWalk[other.actionTime[i],other.actionRowInd[i]] = false;
									
									break;
								}
							}
						}
					}
				}
			}
			
			// Rotation action
			if actionInd[other.actionTime[i],other.actionRowInd[i]] = 1 {
				angleRot[other.actionTime[i],other.actionRowInd[i]] = other.angleRotExport[i];
			}
			
			// Dialogue action
			if actionInd[other.actionTime[i],other.actionRowInd[i]] = 2 {
				width[other.actionTime[i],other.actionRowInd[i]] = other.dialogueWidth[i];
				height[other.actionTime[i],other.actionRowInd[i]] = other.dialogueHeight[i];
				textRows[other.actionTime[i],other.actionRowInd[i]] = other.textRows[i];
				xOffDialogue[other.actionTime[i],other.actionRowInd[i]] = other.xOffDialogue[i];
				yOffDialogue[other.actionTime[i],other.actionRowInd[i]] = other.yOffDialogue[i];
				
				for (j = 0; j < textRows[other.actionTime[i],other.actionRowInd[i]]; j += 1) {
					dialogueStr[other.actionTime[i],j] = other.dialogueStr[i,j];
				}
			}
			
			// Camera pan action
			if actionInd[other.actionTime[i],other.actionRowInd[i]] = 3 {
				panAngle[other.actionTime[i]] = other.panAngle[i];
				panMagnitude[other.actionTime[i]] = other.panMagnitude[i];
				// The maximum speed spans the length of the vector in 1.05 seconds
				panMagnitudeSpdMax[other.actionTime[i]] = other.panMagnitude[i] / (60 * 1.05);
				
				if other.easeInVal[i] != 0 {
					panEaseIn[other.actionTime[i]] = other.easeInVal[i] / 320;
				} else {
					panEaseIn[other.actionTime[i]] = -1;
				}
				if other.easeOutVal[i] != 0 {
					panEaseOut[other.actionTime[i]] = other.easeOutVal[i] / 320;
				} else {
					panEaseOut[other.actionTime[i]] = -1;
				}
			}
			
			// Walk speed action
			if actionInd[other.actionTime[i],other.actionRowInd[i]] = 5 {
				slowSpd[other.actionTime[i],other.actionRowInd[i]] = other.slowSpd[i];
			}
			
			// Arbitrary action
			if actionInd[other.actionTime[i],other.actionRowInd[i]] = 6 {
				arbitraryInd[other.actionTime[i],other.actionRowInd[i]] = other.arbitraryInd[i];
			}
		}
	}
}

with obj_trigger_pan_region_editor {
	// Region collision
	with instance_create_layer(x,y,"Instances",obj_trigger_pan_region_level) {
		x = other.x;
		y = other.y;
		image_xscale = other.width;
		image_yscale = other.height;
		zfloor = other.zfloor;
		polygon = other.polygon;
		angle = other.angle;
		maxMagnitude = real(other.magnitude);
		thresholdCount = 0;
		
		for (i = 0; i < instance_number(obj_trigger_vertex); i += 1) {
			if instance_find(obj_trigger_vertex,i).trg = other.id {
				tempVertex = instance_find(obj_trigger_vertex,i).id;
				
				if tempVertex.hasThreshold {
					thresholdRegion[thresholdCount] = tempVertex.polygon;
					thresholdExitX[thresholdCount] = tempVertex.edgeMidPointX;
					thresholdExitY[thresholdCount] = tempVertex.edgeMidPointY;
					thresholdEntryX[thresholdCount] = tempVertex.edgeMidPointX + tempVertex.thresholdX;
					thresholdEntryY[thresholdCount] = tempVertex.edgeMidPointY + tempVertex.thresholdY
					thresholdLength[thresholdCount] = point_distance(thresholdExitX[thresholdCount],thresholdExitY[thresholdCount],thresholdEntryX[thresholdCount],thresholdEntryY[thresholdCount]);
					
					thresholdCount += 1;
				}
			}
		}
	}
}
