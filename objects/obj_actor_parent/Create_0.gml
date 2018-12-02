/// @description 
str = "actor";

xNode[1] = -1;
yNode[1] = -1;
i = 1;

spd = 0;
maxSpd = 2;
dirIso = 4;

moving = false;
jumping = false;

sprD = spr_ph_down;
sprDDR = spr_ph_ddownright;
sprDR = spr_ph_downright;
sprDRR = spr_ph_rdownright;
sprR = spr_ph_right;
sprURR = spr_ph_rupright;
sprUR = spr_ph_upright;
sprUUR = spr_ph_uupright;
sprU = spr_ph_up;

sprDWalk = spr_ph_down;
sprDDRWalk = spr_ph_ddownright;
sprDRWalk = spr_ph_downright;
sprDRRWalk = spr_ph_rdownright;
sprRWalk = spr_ph_right;
sprURRWalk = spr_ph_rupright;
sprURWalk = spr_ph_upright;
sprUURWalk = spr_ph_uupright;
sprUWalk = spr_ph_up;

spr = sprD;

with instance_create_layer(x,y,"Instances",obj_staircasecollision_mask) {
	trg = other.id;
	other.staircaseMaskObjectIndex = self.id;
}
