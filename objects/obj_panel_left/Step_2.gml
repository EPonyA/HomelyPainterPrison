/// @description Slide out
event_inherited();

if exitInterface {
	exitInterface = false;
	
	moveToX = 0;
	moveToSpd = (x - room_width) / 4;
	moveDirection = -1;
	
	alarm[1] = 18;
}
