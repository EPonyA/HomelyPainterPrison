/// @description 
subPointDisplacement = 0;
col = make_color_rgb(200,210,243); // Cute blue-ish
orange = make_color_rgb(255,160,64); // Light orange

subType[0,1] = 0; // Clipping mask
passIn = false;

plusCol = col;
dieCol = col;

tempMouseX = 0;
tempMouseY = 0;
draggingMouse = false;
draggingMouseInit = false;
dragLayer = -1;
mouseOffY = 0;

depth = -1;