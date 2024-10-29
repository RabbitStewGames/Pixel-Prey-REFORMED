if(STATE != PlayerState.Default){
	VEL.x = 0
	VEL.y = 0
}

if(instance_exists(obj_ui_gameover))
	return

if(!instance_exists(obj_ui_options))
	if(IMMUNITY > 0) IMMUNITY--
	

if(STATE == PlayerState.Dead and !instance_exists(obj_chatbox_ingame)){
	DeathTimer--
	
	if(DeathTimer <= 0){
		var go = instance_create_depth(0,0,-9999, obj_ui_gameover)
		go.deathSource = deathSource
	}
	
	return	
}

if(instance_exists(obj_ui_options) or STATE != PlayerState.Default) {
	image_speed = 0
	return;
	}
	else image_speed = 1

// GROUND CHECK

GROUNDED = (!isfree(x,y + 1) or !isfree(x,y) or !isfree(x,y+2)) and VEL.y >= 0

// MOVEMENT

if(GROUNDED and !GROUNDED_OLD and COYOTE_TIME == 0) {
	ACTIVE_ANIMATION = ANIM_LAND
	LOCK_ANIMATION = true
}

if(GROUNDED)
{
	COYOTE_TIME = 10
	GROUNDPOUNDING = false
	if(DOWN){
		if ((!LEFT and !RIGHT) or (LEFT and RIGHT)) // TODO replace with crawl anim
		{
			VEL.x = towards(VEL.x, 0, .8)
		}
		else if(RIGHT)
		{
			VEL.x = towards(VEL.x, MOVE_SPEED/4, .8)
		}
		else if(LEFT) 
		{
			VEL.x = towards(VEL.x, -MOVE_SPEED/4, .8)
		}
		
		JUMPBOOST_TIMER--
	}
	else if(!UP) {
		if ((!LEFT and !RIGHT) or (LEFT and RIGHT))
		{
			VEL.x = towards(VEL.x, 0, FRICTION)
		}
		else if(RIGHT)
		{
			if(abs(VEL.x) <=.1 and DIRECTION == 0) {
				ACTIVE_ANIMATION = ANIM_SLOWTURN
				LOCK_ANIMATION = true
			}
			VEL.x = towards(VEL.x, MOVE_SPEED, FRICTION)
		}
		else if(LEFT) 
		{
			if(abs(VEL.x) <=.1 and DIRECTION == 1) {
				ACTIVE_ANIMATION = ANIM_SLOWTURN
				LOCK_ANIMATION = true
			}
			VEL.x = towards(VEL.x, -MOVE_SPEED, FRICTION)
		}
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
	
		if(VEL.y < 0 and !isfree(x,y+VEL.y/60) and BONK_TIMER <= 0) 
		{
			audio_play_sound_on(obj_gamemanager.EMITTER_SFX, SFX_BONK, false, 0, .75, undefined, random_range(.9, 1.1))
			BONK_TIMER = BONK_DELAY
			ACTIVE_ANIMATION = ANIM_BONK
			LOCK_ANIMATION = true
		}
	
		if(global.duck_pressed and !GROUNDPOUNDING and !SUBMERGED)
		{
			audio_play_sound_on(obj_gamemanager.EMITTER_SFX, SFX_DASH, 0, false)
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

if(SUBMERGED){
	if(VEL.x > 0) DIRECTION = 1	
	else if(VEL.x < 0) DIRECTION = 0	
}

if(BONK_TIMER == BONK_DELAY){
	VEL.y = -500
	BONK_TIMER--
}
else if(BONK_TIMER > 0) {
	VEL.y = 0
	BONK_TIMER--
}
else if(BONK_TIMER == 0){
	BONK_TIMER = -1
	VEL.y = 100
}

if(!DOWN or !GROUNDED) JUMPBOOST_TIMER = 60

if(JUMP and (GROUNDED or (!GROUNDED && COYOTE_TIME > 0) or SUBMERGED)) {
	
	if(SUBMERGED)
	{
		ACTIVE_ANIMATION = ANIM_SWIM_UP
		image_index = ANIM_SWIM_UP[0]
		LOCK_ANIMATION = true
	}
	else
	{
		ACTIVE_ANIMATION = ANIM_JUMP
		image_index = ANIM_JUMP[0]
		LOCK_ANIMATION = true
	}
	
	JUMPING = true
	
	if(DOWN or SUBMERGED) JUMP_TIMER = JUMP_DELAY
}

if(JUMPING) JUMP_TIMER++
else JUMP_TIMER = 0

if(JUMP_TIMER >= JUMP_DELAY)
{
	JUMP_TIMER = 0
	JUMPING = false
	
	VEL.y = -JUMP_HEIGHT
	
	if(JUMPBOOST_TIMER <= 0)
		VEL.y *= 1.5
		
	COYOTE_TIME = 0
	
	if(SUBMERGED)
		audio_play_sound_on(obj_gamemanager.EMITTER_SFX, SFX_SWIM, 0, false)
	else
	{
		if(JUMPBOOST_TIMER<=0)
			audio_play_sound_on(obj_gamemanager.EMITTER_SFX, SFX_JUMP, false, 0, 1, 0, 1.25)
		else
			audio_play_sound_on(obj_gamemanager.EMITTER_SFX, SFX_JUMP, false, 0, 1, 0, random_range(.8,1.2))
	}
}

if(DASH and DASH_COOLDOWN <= 0 and !GROUNDPOUNDING){
	 audio_play_sound_on(obj_gamemanager.EMITTER_SFX, SFX_DASH, 0, false)
	 DASH_TIMER = 10
	 DASH_PUNISHMENT+=1.5
	 DASH_COOLDOWN = 30 * DASH_PUNISHMENT
	 GUI_DASH_PUNISHMENT = DASH_COOLDOWN
	 
	 if(LEFT) DIRECTION = 0
	 if(RIGHT) DIRECTION = 1
	 
	 obj_view.ShakeScreen(.5, 12)
	 obj_view.ZOOM = 1.05
}

if(GROUNDED){
	if(UP){
		if(LOOKUP_TIMER >0) LOOKUP_TIMER--
		else 
			obj_view.Y_OFFSET = -100
	}else LOOKUP_TIMER = 30
}
else
{
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

VEL.x = round(VEL.x)
VEL.y = round(VEL.y)

if(abs(VEL.x) <= 10 and !LEFT and !RIGHT) VEL.x = 0

move_and_collide(VEL.x / 60, VEL.y / 60, [obj_clip, TILEMAP], 8)
x=round(x)
y=round(y)


// ANIMATION

if(GROUNDED and DOWN and !DOWN_OLD) {
	ACTIVE_ANIMATION = ANIM_CROUCH_BEGIN
	LOCK_ANIMATION = true
}
if(GROUNDED and !DOWN and DOWN_OLD) {
	ACTIVE_ANIMATION = ANIM_CROUCH_END
	LOCK_ANIMATION = true
}

var deltaX = x - X_OLD

if(!LOCK_ANIMATION and (GROUNDED or COYOTE_TIME > 0))
{
	if(DOWN)
	{
		if(deltaX == 0) ACTIVE_ANIMATION = ANIM_CROUCH_IDLE
		if((LEFT and deltaX < 0)or(RIGHT and deltaX > 0)) ACTIVE_ANIMATION = ANIM_CRAWL
	}
	else
	{
		if(deltaX == 0) ACTIVE_ANIMATION = ANIM_IDLE
		if((LEFT and deltaX < 0)or(RIGHT and deltaX > 0)) ACTIVE_ANIMATION = ANIM_RUN
		if((RIGHT and deltaX < 0)or(LEFT and deltaX > 0)) ACTIVE_ANIMATION = ANIM_QUICKTURN
	
		if(!LEFT and !RIGHT and deltaX != 0) 
		{
			ACTIVE_ANIMATION = ANIM_STOP
			LOCK_ANIMATION = true
		}
	}
}

if(LOCK_ANIMATION)
{
	if(image_index > ACTIVE_ANIMATION[array_length(ACTIVE_ANIMATION) - 1]){
		if 	(ACTIVE_ANIMATION == ANIM_LAND or
			ACTIVE_ANIMATION == ANIM_BONK or
			ACTIVE_ANIMATION == ANIM_CROUCH_BEGIN or
			ACTIVE_ANIMATION == ANIM_CROUCH_END or
			ACTIVE_ANIMATION == ANIM_SLOWTURN or
			ACTIVE_ANIMATION == ANIM_STOP or
			ACTIVE_ANIMATION == ANIM_SWIM_UP or
			ACTIVE_ANIMATION == ANIM_BONK)
			LOCK_ANIMATION = false
	}
}

if(!LOCK_ANIMATION)
{
	if(image_index >= ACTIVE_ANIMATION[array_length(ACTIVE_ANIMATION) - 1] + 1 or image_index < ACTIVE_ANIMATION[0]) image_index = ACTIVE_ANIMATION[0]

	if(!GROUNDED and VEL.y > 0){
		if(SUBMERGED)
			ACTIVE_ANIMATION = ANIM_SWIM_DOWN
		else
			ACTIVE_ANIMATION = ANIM_MIDAIR_DOWN
	}
	
}
else
{
	if(image_index >= ACTIVE_ANIMATION[array_length(ACTIVE_ANIMATION) - 1] + 1) image_index = ACTIVE_ANIMATION[array_length(ACTIVE_ANIMATION) - 1]
	else if(image_index < ACTIVE_ANIMATION[0]) image_index = ACTIVE_ANIMATION[0]
}

if(!GROUNDED  and (VEL.y < 0 and ACTIVE_ANIMATION == ANIM_JUMP and image_index > ANIM_JUMP[array_length(ANIM_JUMP)-1]))
		ACTIVE_ANIMATION = ANIM_MIDAIR_UP

if(DIRECTION == 1) image_xscale = 2
else image_xscale = -2


if(SUBMERGED)
{
	DamageMe(DamageSource.Acid, 1)
	
	if(random(1) >= .99) instance_create_depth(x,y - sprite_height + 32, depth-1,obj_effect_bubbles)
}

if(FOOTSTEP_TIMER > 0) FOOTSTEP_TIMER--

if(ACTIVE_ANIMATION == ANIM_RUN and !DOWN and FOOTSTEP_TIMER == 0 and GROUNDED and ((LEFT and deltaX < 0) or (RIGHT and deltaX > 0))) {
	audio_play_sound_on(obj_gamemanager.EMITTER_SFX, SFX_FOOTSTEPS[irandom(array_length(SFX_FOOTSTEPS)-1)], false, 0, 1, 0, random_range(.8,1.2))
	FOOTSTEP_TIMER = FOOTSTEP_DELAY
}

if(GROUNDED and deltaX != 0 and ((LEFT_OLD and !LEFT)or(RIGHT_OLD and !RIGHT)))	audio_play_sound_on(obj_gamemanager.EMITTER_SFX, SFX_SLIDE, false, 0, 1, 0, random_range(.8,1.2))
if(GROUNDED and !GROUNDED_OLD) {
	instance_create_depth(x - sprite_width / 4,y, depth-1,obj_effect_land)
	audio_play_sound_on(obj_gamemanager.EMITTER_SFX, SFX_LAND, false, 0, 1, 0, random_range(.8,1.2))
}

if(global.up_pressed and GROUNDED)
{
	if(place_meeting(x,y,obj_goal))
	{
		instance_create_depth(0,0, -9999, obj_stagetransition)
	}
}

//if(SUBMERGED != SUBMERGED_OLD) audio_play_sound_on(obj_levelmanager.EMITTER_SFX, SFX_SPLASH, 0, false)