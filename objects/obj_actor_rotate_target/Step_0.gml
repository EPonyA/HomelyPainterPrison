/// @description Insert description here
event_inherited();

if (mouse_check_button_released(mb_left)) {
	if canRelease {
		if canDel {
			with trg {
				angle = other.angleExport;
				trg.dirIsoDef = other.angleExport;
			}
			
			instance_destroy();
		} else {
			canDrag = true;
			canPlace = false;
			
			alarm[0] = 18;
		}
	} else {
		// The first mouse button release does not count
		canRelease = true;
	}
}
