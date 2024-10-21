if(global.halloweenEvent) draw_sprite_stretched(s_titlebg_halloween, 0, 0, 0, window_get_width(), window_get_height())

draw_set_alpha(.75)
draw_set_color(c_black)
draw_rectangle(0, 0, window_get_width(), window_get_height(), false)

draw_set_alpha(1)
draw_set_color(c_white)

if(state == 0)
{
	draw_sprite_ext(s_logo_sub, 0, window_get_width()/2, max(window_get_height()-250+subtitle_y_offset, window_get_height()/2 + 75), global.GameScale -.5, global.GameScale -.5, 0, c_white, 1)

	if(global.halloweenEvent)
		draw_sprite_ext(s_logo_halloween, 0, window_get_width()/2, window_get_height()/2-100+title_y_offset, global.GameScale, global.GameScale, title_rot, c_white, 1)
	else
		draw_sprite_ext(s_logo_halloween, 0, window_get_width()/2, window_get_height()/2-100+title_y_offset, global.GameScale, global.GameScale, title_rot, c_white, 1)

	draw_sprite_ext(s_title_clicktostart, 0, window_get_width()/2, window_get_height()-100, global.GameScale-.5, global.GameScale-.5, 0, c_white, 1)
}

if(transition_timer > 0) {
	draw_set_color(c_black)
	draw_set_alpha(transition_timer / 60)
	draw_rectangle(0, 0, window_get_width(), window_get_height(), false)
}


if(transition_timer_exit > 0) {
	draw_set_color(c_black)
	draw_set_alpha(max(1 - transition_timer_exit / 60, 0))
	draw_rectangle(0, 0, window_get_width(), window_get_height(), false)
}

draw_set_alpha(1)