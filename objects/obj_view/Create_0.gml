TARGET = obj_player

SHAKE_PERIOD = 15.0

SHAKE_TIMER = 0
SHAKE_INTENSITY = 8
SHAKE_OFFSET = 0

X_OFFSET = 0
Y_OFFSET = 0

ZOOM = 1
TARGET_ZOOM = 1

CAMERA = -5

ShakeScreen = function(duration, intensity){
	
	SHAKE_TIMER = duration
	SHAKE_INTENSITY = intensity
	
}

Reset = function()
{
	CAMERA = camera_create_view(0,0, 1024, 576, 0, noone, -1, -1, 400, 250)
	view_camera[0] = CAMERA
	view_visible[0] = true
}