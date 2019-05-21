/// @description Manipulating dimensions
event_inherited();

// Initially generate a 1x1 square polygon region
if placed = 1 {
	with instance_create_layer(x,y,"Instances",obj_trigger_vertex_pan) {
		other.vertexInstanceId[self.vertexInd] = self.id;
		self.trg = other.id;
		self.vertexToInd = instance_number(obj_trigger_vertex_pan) + 2;
		trgXOff = x - other.x;
		trgYOff = y - other.y ;
	}
	with instance_create_layer(x+20,y,"Instances",obj_trigger_vertex_pan) {
		other.vertexInstanceId[self.vertexInd] = self.id;
		self.trg = other.id;
		self.vertexToInd = instance_number(obj_trigger_vertex_pan) - 1;
		trgXOff = x - other.x;
		trgYOff = y - other.y ;
	}
	with instance_create_layer(x,y+20,"Instances",obj_trigger_vertex_pan) {
		other.vertexInstanceId[self.vertexInd] = self.id;
		self.trg = other.id;
		self.vertexToInd = instance_number(obj_trigger_vertex_pan) + 1;
		trgXOff = x - other.x;
		trgYOff = y - other.y ;
	}
	with instance_create_layer(x+20,y+20,"Instances",obj_trigger_vertex_pan) {
		other.vertexInstanceId[self.vertexInd] = self.id;
		self.trg = other.id;
		self.vertexToInd = instance_number(obj_trigger_vertex_pan) - 2;
		trgXOff = x - other.x;
		trgYOff = y - other.y ;
	}
	
	recalculate = true;
	placed = 2;
}

// Dimensional manipulation
if spawnButtons {
	spawnButtons = false;
	
	with instance_create_layer(x,y,"Instances",obj_arrow_editor_drag) {
		trg = other.id;
	}
	with instance_create_layer(x+width*10,y+height*10,"Instances",obj_arrow_editor_z3) {
		trg = other.id;
	}
	with instance_create_layer(x,y+20,"Instances",obj_x_editor) {
		trg = other.id;
	}
	
	with instance_create_layer(x,y,"Instances",obj_region_button_vertex) {
		sortIndex = 0;
		viewOn = 5;
		panelId = obj_subpanel_left.id;
	}
	with instance_create_layer(x,y,"Instances",obj_region_button_edge) {
		sortIndex = 1;
		viewOn = 5;
		panelId = obj_subpanel_left.id;
	}
	
	with obj_trigger_vertex_pan {
		if trg = other.id {
			alarm[0] = 2;
		}
	}
	
	obj_subpanel_left.tempY = obj_subpanel_left.y;
	obj_subpanel_left.moveDirection = 1;
	obj_subpanel_left.moveToY = obj_panel_bot.y;
	obj_subpanel_left.moveToSpd = (obj_panel_bot.y - obj_subpanel_left.y)/6.5;
	
	// Standard formula to solve for time, given speed and distance
	// +5 is a pause to dramatize the motion
	obj_subpanel_left.alarm[1] = abs(obj_panel_bot.y - obj_subpanel_left.y) / obj_subpanel_left.moveToSpd + 5;
}

zcieling = zfloor;

if select {
	// Create ds_list from ordered pairs of vertex coordinates
	/*if recalculate {
		recalculate = false;
		vertexCountTemp = 0;
		
		if instance_exists(obj_trigger_vertex_pan) { // 0 vertices broke this system
			broken = false;
		}
		
		for (i = 0; i < instance_number(obj_trigger_vertex_pan); i += 1) {
			if instance_find(obj_trigger_vertex_pan,i).trg = self.id {
				vertexCountTemp += 1;
				tempInstanceStart = instance_find(obj_trigger_vertex_pan,i).id; // Arbitrarily assign vertex n[0]
				
				if instance_find(obj_trigger_vertex_pan,i).vertexToInd = -1 { // If the polygon is broken
					broken = true;
					break;
				}
			}
		}
		
		if vertexCountTemp <= 2 {
			// If the polygon is a single line
			broken = true;
		}
		
		if !broken {
			ds_list_clear(list); // Reset the list
			tempInstanceVal = tempInstanceStart;
			
			i = 0; // Start from vertex n[0]
			while i < vertexCountTemp { // Iterate through the number of active vertices
				for (j = 0; j < instance_number(obj_trigger_vertex_pan); j += 1) { // Iterate through every existent vertex
					if instance_find(obj_trigger_vertex_pan,j).trg = self.id { // Reduce to exclusively active vertices
						if instance_find(obj_trigger_vertex_pan,j).vertexInd = tempInstanceVal.vertexToInd { // Check if this vertex is next in order	
							tempInstanceVal = instance_find(obj_trigger_vertex_pan,j).id;
							
							ds_list_add(list,tempInstanceVal.x);
							ds_list_add(list,tempInstanceVal.y);
							
							i += 1; // Move onto the next vertex
							break;
						}
					}
				}
			}
			
			// Generate list of triangles
			polygon = scr_polygon_to_triangles(list);
		}
	}*/
	
	if instance_exists(obj_region_button_edge) {
		obj_region_button_edge.trg = self.id; // This button instance couples itself to pass some values
	}
}
