
//x=clamp(x,global.GameWidth / 2, room_width - global.GameWidth / 2)
//y=clamp(y,global.GameHeight / 2, room_height - global.GameHeight / 2)
	
	
camera_set_view_pos(view_camera[0], x, y)
camera_set_view_size(view_camera[0], global.GameWidth / ZOOM, global.GameHeight / ZOOM)
