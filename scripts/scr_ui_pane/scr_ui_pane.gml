enum PANE_TYPE
{
	view,
	inspector,
	dope
}

uiCompCorner = function(_x, _y, _mirror, _flip) constructor
{
	xPos = _x;
	yPos = _y;
	mirror = _mirror;
	flip = _flip;
}

uiPane = function() constructor
{
	pane_type = PANE_TYPE.view;
	components = ds_list_create();

	render_surface = function(_width, _height)
	{
		var return_surface = surface_create(_width, _height);
		surface_set_target(return_surface);

		draw_clear(c_red);

		surface_reset_target();
		return return_surface;
	}
	
	recurse_coord_in_bounds = function(_x, _y)
	{
		// TODO: Make binary R tree to loop search for components faster.
	}
}
