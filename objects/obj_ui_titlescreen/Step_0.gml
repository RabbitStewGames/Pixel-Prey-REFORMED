if(state == 0){
	title_y_offset = sin(current_time * pi * sin_period) * sin_amplitude
	subtitle_y_offset = sin((current_time - 500) * pi * sin_period) * sin_amplitude
	title_rot = sin(current_time * pi * sin_period/2) * 5
	
	if(mouse_check_button(mb_left)){
		room_goto(rm_chat)
	}
}