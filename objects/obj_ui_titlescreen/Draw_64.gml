if(state == 0)
{
	draw_sprite_ext(s_logo_sub, 0, window_get_width()/2, window_get_height()/2+75+subtitle_y_offset, 1.5, 1.5, 0, c_white, 1)

	if(global.halloweenEvent)
		draw_sprite_ext(s_logo_halloween, 0, window_get_width()/2, window_get_height()/2-100+title_y_offset, 1.5, 1.5, title_rot, c_white, 1)
	else
		draw_sprite_ext(s_logo_halloween, 0, window_get_width()/2, window_get_height()/2-100+title_y_offset, 1.5, 1.5, title_rot, c_white, 1)

	draw_sprite_ext(s_title_clicktostart, 0, window_get_width()/2, window_get_height()-100, 1.5, 1.5, 0, c_white, 1)
}