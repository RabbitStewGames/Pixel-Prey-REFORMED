if(!EXITING and image_index == image_number - 1){
	EXITING = true
	image_speed = -1
	obj_levelmanager.NextStage()
}

if(EXITING and image_index == 0) instance_destroy()