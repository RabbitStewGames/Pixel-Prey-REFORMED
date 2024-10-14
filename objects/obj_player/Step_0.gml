// GROUND CHECK

GROUNDED = (!isfree(x,y + 1) or !isfree(x,y) or !isfree(x,y+2)) and VEL.y >= 0

// MOVEMENT

if(GROUNDED)
{
	GROUNDPOUNDING = false
	COYOTE_TIME = 15
	if(DOWN){
		if ((!LEFT and !RIGHT) or (LEFT and RIGHT)) VEL.x = towards(VEL.x, 0, .8)
		else if(RIGHT) VEL.x = towards(VEL.x, MOVE_SPEED/4, .8)
		else if(LEFT) VEL.x = towards(VEL.x, -MOVE_SPEED/4, .8)
		
		if(!LEFT and !RIGHT) JUMPBOOST_TIMER--
		else JUMPBOOST_TIMER = 30
	}
	else if(!UP) {
		if ((!LEFT and !RIGHT) or (LEFT and RIGHT)) VEL.x = towards(VEL.x, 0, FRICTION)
		else if(RIGHT) VEL.x = towards(VEL.x, MOVE_SPEED, FRICTION)
		else if(LEFT) VEL.x = towards(VEL.x, -MOVE_SPEED, FRICTION)
	}
	
	if(UP) VEL.x = towards(VEL.x, 0, FRICTION)
	
	if(VEL.x > 0) DIRECTION = 1
	else if(VEL.x < 0) DIRECTION = 0
	
	VEL.y = 0
	
	
	if(!DOWN and !UP) obj_view.Y_OFFSET = 0
}
else
{
	if(!GROUNDPOUNDING)
	{
		obj_view.Y_OFFSET = 0
	
		VEL.y += GRAVITY
	
		if ((!LEFT and !RIGHT) or (LEFT and RIGHT)) VEL.x = towards(VEL.x, 0, .1)
		else if(RIGHT) VEL.x = towards(VEL.x, MOVE_SPEED, .1)
		else if(LEFT) VEL.x = towards(VEL.x, -MOVE_SPEED, .1)
	
		if(COYOTE_TIME > 0)
			COYOTE_TIME--
	
		if(VEL.y < 0 and !isfree(x,y+VEL.y/60)) VEL.y = 0
	
		if(keyboard_check_pressed(vk_down) and !GROUNDPOUNDING and !SUBMERGED)
		{
			audio_play_sound_on(obj_levelmanager.EMITTER_SFX, SFX_DASH, 0, false)
			GROUNDPOUNDING = true
			VEL.y = 1000
		}
	}
	else
	{
		var ai = instance_create_depth(x,y,depth+1,obj_afterimage)
		ai.sprite_index = sprite_index
		ai.image_index = image_index
		ai.image_xscale = image_xscale
		ai.image_yscale = image_yscale
		
		VEL.x = 0
		
		var deltaY = y - Y_OLD
	}
}

if(!DOWN or !GROUNDED) JUMPBOOST_TIMER = 30

if(JUMP and (GROUNDED or (!GROUNDED && COYOTE_TIME > 0) or SUBMERGED)) {
	VEL.y = -JUMP_HEIGHT
	
	if(JUMPBOOST_TIMER <= 0)
		VEL.y *= 1.5
		
	COYOTE_TIME = 0
	
	if(SUBMERGED)
		audio_play_sound_on(obj_levelmanager.EMITTER_SFX, SFX_SWIM, 0, false)
	else
		audio_play_sound_on(obj_levelmanager.EMITTER_SFX, SFX_JUMP, 0, false)
}

if(DASH and DASH_COOLDOWN <= 0 and !GROUNDPOUNDING){
	 audio_play_sound_on(obj_levelmanager.EMITTER_SFX, SFX_DASH, 0, false)
	 DASH_TIMER = 10
	 DASH_PUNISHMENT+=1.5
	 DASH_COOLDOWN = 30 * DASH_PUNISHMENT
	 
	 if(LEFT) DIRECTION = 0
	 if(RIGHT) DIRECTION = 1
	 
	 obj_view.ShakeScreen(.5, 12)
	 obj_view.ZOOM = 1.05
}

if(GROUNDED){
	if(DOWN and (!LEFT and !RIGHT)){
		if(LOOKDOWN_TIMER >0) LOOKDOWN_TIMER--
		else 
			obj_view.Y_OFFSET = 100
	}else LOOKDOWN_TIMER = 60

	if(UP){
		if(LOOKUP_TIMER >0) LOOKUP_TIMER--
		else 
			obj_view.Y_OFFSET = -100
	}else LOOKUP_TIMER = 30
}
else
{
	LOOKDOWN_TIMER = 60
	LOOKUP_TIMER = 30
}

DASH_PUNISHMENT = towards(DASH_PUNISHMENT, 0, 0.0075)

if(DASH_COOLDOWN > 0) DASH_COOLDOWN--

if(DASH_TIMER > 0 and !GROUNDPOUNDING) {
	DASH_TIMER--
	VEL.y = 0
	VEL.x = 750
	if(DIRECTION == 0) VEL.x *= -1
	
	var ai = instance_create_depth(x,y,depth+1,obj_afterimage)
	ai.sprite_index = sprite_index
	ai.image_index = image_index
	ai.image_xscale = image_xscale
	ai.image_yscale = image_yscale
}
else if(DASH_TIMER == 0){
	DASH_TIMER--
	VEL.x = 0
}

if(SUBMERGED)
{
	GROUNDPOUNDING = false
	VEL.y = clamp(VEL.y, -300, 50)
	VEL.x = clamp(VEL.x, -MOVE_SPEED/3, MOVE_SPEED/3)
}

// COLLISION & MOVEMENT APPLICATION

for(var i = 0; i < STEP_HEIGHT + 1; i++){
	if(VEL.x > 0)
	{
		if(!isfree(x  + 1, y) and isfree(x + 1, y - i))
			y--
	}
	else if(VEL.x < 0)
	{
		if(!isfree(x - 1, y) and isfree(x - 1, y - i))
			y--
	}
}

for(var i = 0; i < STEP_HEIGHT + 1; i++){
	if(VEL.x > 0)
	{
		if(isfree(x + 1, y) and isfree(x + 1, y + i) and !isfree(x + 1, y + i + 1))
			y++
	}
	else if(VEL.x < 0)
	{
		if(isfree(x - 1, y) and isfree(x - 1, y + i) and !isfree(x - 1, y + i + 1))
			y++
	}
}

if(!isfree(x,y)) y--

move_and_collide(VEL.x / 60, VEL.y / 60, [obj_clip, TILEMAP], 8)
x=round(x)
y=round(y)

/*
if(!place_meeting(x +VEL.x / 60, y, obj_clip))
	x += VEL.x / 60
if(!place_meeting(x, y + VEL.y / 60, obj_clip))
	y += VEL.y / 60
else if(VEL.y > 0 and not GROUNDED)
{
	var originalY = round(y)
	for(var i = 1; i < 8; i++)
	{
		if(!place_meeting(x,originalY,obj_clip) and place_meeting(x, originalY+i, obj_clip)) {
			y=originalY+i-1; 
			GROUNDED = true
			break
		}
	}
}
*/
// ANIMATION

var deltaX = x - X_OLD

if(ANIM_TIMER == 0){
	if(GROUNDED){
		
		if((LEFT or RIGHT) and !UP){
			if(!DOWN){
				if((LEFT and deltaX > 0) or (RIGHT and deltaX < 0))
				{
					ANIM_FRAME = 13
					ANIM_TIMER = 0
				}
				else
				{
					ANIM_TIMER = ANIM_DELAY
					ANIM_FRAME++
			
					if(ANIM_FRAME > 3) ANIM_FRAME = 0
				}
			}
			else{
				ANIM_TIMER = ANIM_DELAY * 2
				ANIM_FRAME++
			
				if(ANIM_FRAME < 6 or ANIM_FRAME > 9) ANIM_FRAME = 6
			}
		}
		else{
			if((deltaX > 0.1 or deltaX < -0.1) and !DOWN){
				ANIM_TIMER = 0
				ANIM_FRAME = 12
			}
			else{
				ANIM_TIMER = 0
				ANIM_FRAME = 0
				if(DOWN) ANIM_FRAME = 6
				if(UP) ANIM_FRAME = 10
			}
		}
		
	}
	else{
		if(VEL.y < 0) ANIM_FRAME = 4
		else ANIM_FRAME = 5
	}
	
} else ANIM_TIMER--

image_index = ANIM_FRAME

if(DIRECTION == 1) image_xscale = 2
else image_xscale = -2

if(IMMUNITY > 0) IMMUNITY--

if(SUBMERGED)
{
	DamageMe(DamageSource.Acid, 1)
}

//if(SUBMERGED != SUBMERGED_OLD) audio_play_sound_on(obj_levelmanager.EMITTER_SFX, SFX_SPLASH, 0, false)