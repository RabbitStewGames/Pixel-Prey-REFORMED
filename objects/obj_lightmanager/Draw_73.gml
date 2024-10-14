if (!surface_exists(lighting_surface))
{
    Reset()
}
else
{
	var _cw = camera_get_view_width(view_camera[0]);
	var _ch = camera_get_view_height(view_camera[0]);
	var _cx = camera_get_view_x(view_camera[0]);
	var _cy = camera_get_view_y(view_camera[0]);
	surface_set_target(lighting_surface);
	draw_set_color(light_ambient);
	draw_set_alpha(0.8);
	draw_rectangle(0, 0, _cw, _ch, 0);
	gpu_set_blendmode(bm_normal);
		
	with (obj_lit)
	{
		var _sw = sprite_width / 2;
		var _sh = sprite_height / 2;
		switch(object_index)
		{
			case obj_player:
				draw_sprite_ext(s_light_point, 0, x - _cx, y - _sh - _cy, 1, 1, 0, c_white, 1);            
				break;
		}
	}
		
	gpu_set_blendmode_ext(bm_dest_color, bm_zero);
	draw_set_alpha(1);
	surface_reset_target();
	draw_surface(lighting_surface, _cx, _cy);
	gpu_set_blendmode(bm_normal)
}