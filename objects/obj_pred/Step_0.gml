if(ANIM_TIMER > 0) ANIM_TIMER--
else{
	ANIM_TIMER = ANIM_DELAY
	ANIM_FRAME++

	if(ANIM_FRAME >= image_number) ANIM_FRAME = 0

	image_index = ANIM_FRAME
}

image_xscale = 4
image_yscale = 4

y = room_height - sprite_height
x = room_width - sprite_width