if(ate_player)
{
	var promptscale = 4
	
	var X_SCREEN = x - camera_get_view_x(obj_view.CAMERA)
	X_SCREEN *= global.GameScale
	var Y_SCREEN = y - camera_get_view_y(obj_view.CAMERA) - sprite_height
	Y_SCREEN *= global.GameScale

	var l = (X_SCREEN - 32 * global.GameScale)
	var r = (X_SCREEN + 32 * global.GameScale)
	var t = Y_SCREEN - 10
	var b = Y_SCREEN - 4
	var fill = lerp(l,r,escape_progress/escape_requirement)

	draw_sprite_ext(s_prompt_wiggle, prompt_frame, X_SCREEN - (sprite_get_width(s_prompt_wiggle) * promptscale)/2, Y_SCREEN-(sprite_get_width(s_prompt_wiggle) * promptscale), promptscale, promptscale, 0, c_white, 1)

	draw_set_color(c_white)
	draw_rectangle(l,b,fill,t, false)

}