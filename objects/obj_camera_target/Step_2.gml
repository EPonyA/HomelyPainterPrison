/// @description Depth calculation
// Draw above target instance
if instance_exists(trg) {
	depth = obj_editor_gui.depth -(trg.y + zfloor*20 + 20) - zfloor - room_height - 101;
}
