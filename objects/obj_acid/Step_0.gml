if(instance_exists(obj_ui_options)){
	image_speed = 0
	return;
}
else image_speed = .25

y_offset = sin(current_time * pi * sin_period) * sin_amplitude
x = sin(current_time * pi * sin_period) * sin_amplitude * 2

y = room_height - global.acid_height + y_offset
global.acidheight_drawn = y