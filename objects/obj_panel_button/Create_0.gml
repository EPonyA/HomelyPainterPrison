/// @description Insert description here
select = false;
canRelease = false;
objIndex = -1;
imgIndex = 0;

sortX = 0;
sortY = 0;
sprWidth = -1;
longestSprWidth = -1;
sprHeight = 30;
width = -1;
label = "";
insideCol = make_color_rgb(255,160,64); // Light orange
buttonType = 0; // 0 is a generic button, 1 is a wheel button, 2 is a value input button
relativeMouseX = -1;
relativeMouseY = -1;
angle = -1;
decimalPlace = -1;

perimeterCol = make_color_rgb(63,70,87); // Light gray
perimeterInsideCol = make_color_rgb(28,30,36); // Very dark gray
graphicFillInsideCol = make_color_rgb(35,38,45); // Mid-tone gray
graphicFillOutsideCol = make_color_rgb(31,34,40); // Dark gray
graphicCol1 = make_color_rgb(200,210,243);
graphicCol2 = make_color_rgb(147,155,179);

alarm[0] = 2;

font = obj_editor_gui.font;
