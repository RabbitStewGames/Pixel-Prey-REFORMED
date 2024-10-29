if(state == 0){
	title_y_offset = sin(current_time * pi * sin_period) * sin_amplitude
	subtitle_y_offset = sin((current_time - 500) * pi * sin_period) * sin_amplitude
	title_rot = sin(current_time * pi * sin_period/2) * 5
	
	if(global.jump and accepting_input and !instance_exists(obj_ui_options)){
		transition_timer_exit = 60
		accepting_input = false
	}
	
	if(accepting_input and (keyboard_check_pressed(vk_escape) or gamepad_button_check_pressed(0, gp_face2)) and !instance_exists(obj_ui_options))
	{
		instance_create_depth(0,0,-9999, obj_ui_options)	
	}
}

if(transition_timer > 0) transition_timer--
else if(transition_timer == 0) {
	accepting_input = true
	transition_timer--
}

if(transition_timer_exit > 0) {
	transition_timer_exit--
	audio_emitter_gain(obj_gamemanager.EMITTER_MUSIC, audio_emitter_get_gain(obj_gamemanager.EMITTER_MUSIC) - .02)	
}
else if(transition_timer_exit == 0) {
	audio_stop_all()
	audio_emitter_gain(obj_gamemanager.EMITTER_MUSIC, .5)
	room_goto(rm_chat)
	transition_timer_exit--
}