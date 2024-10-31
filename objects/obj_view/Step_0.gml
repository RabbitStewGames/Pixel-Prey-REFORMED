if(instance_exists(obj_ui_options)) return;

if(!instance_exists(TARGET)){
	return	
}

var delta = 1/60
SHAKE_TIMER = max(0, SHAKE_TIMER - delta)

SHAKE_OFFSET = sin(SHAKE_TIMER * pi * SHAKE_PERIOD) * SHAKE_TIMER * SHAKE_INTENSITY

if(SHAKE_TIMER == 0){
	var tarX = (TARGET.x + SHAKE_OFFSET - global.GameWidth / 2 + X_OFFSET)
	tarX=max(tarX,0)
	tarX = min(tarX, room_width - camera_get_view_width(obj_view.CAMERA))

	var tarY = (TARGET.y - global.GameHeight / 2 + Y_OFFSET) 
	tarY = clamp(tarY,0, room_height - global.GameHeight)

	var dstX = tarX - x
	var dstY = tarY - y

	var xPercent = dstX * 0.05
	var yPercent = dstY * 0.05

	x += xPercent
	y += yPercent
}
else{
	var tarX = (TARGET.x + SHAKE_OFFSET - global.GameWidth / 2 + X_OFFSET)
	tarX=max(tarX,0)
	tarX = min(tarX, room_width - camera_get_view_width(obj_view.CAMERA))

	var tarY = (TARGET.y - global.GameHeight / 2 + Y_OFFSET) 
	tarY = clamp(tarY,0, room_height - global.GameHeight)
	var dstY = tarY - y
	
	var yPercent = dstY * 0.05
	
	x = tarX
	y += yPercent
}

ZOOM = lerp(ZOOM,TARGET_ZOOM,0.1)

