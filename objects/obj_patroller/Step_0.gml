if(instance_exists(obj_ui_options)) {
	
	image_speed = 0
	exit;
	
}

if(active_animation == attributes.anim.capture)
	image_speed = .5
else
	image_speed = 1
	
image_xscale = Direction * 2
	
// Movement


if(place_meeting(x + Direction, y, obj_levelmanager.TILEMAP) or tilemap_get_at_pixel(obj_levelmanager.TILEMAP, x + Direction, y + 1) == 0 /*or !place_meeting(x + vel.x / 60, y + sprite_height + 1, obj_levelmanager.TILEMAP)*/) Direction = -Direction


if(place_meeting(x,y,obj_levelmanager.TILEMAP)) y--

if(!dead_af and stun <= 0){
	if(Direction == 1) vel.x = attributes.move_speed
	if(Direction == -1) vel.x = -attributes.move_speed
}

//vel.y = 300

// Animation
	

if(active_animation != attributes.anim.capture and image_index > active_animation[array_length(active_animation)-1] or image_index < active_animation[0])
	image_index = active_animation[0]
	
if(active_animation == attributes.anim.capture){
	if(image_index < active_animation[0]) image_index = active_animation[0]
	else if(image_index >= active_animation[array_length(active_animation)-1]) active_animation = attributes.anim.hold
}

if(vel.x != 0 and !dead_af and !ate_player)
	active_animation = attributes.anim.move

if(obj_player.STATE == PlayerState.Dead and !dead_af){
	active_animation = attributes.anim.idle
	ate_player = false
	return;
}

if(dead_af){
	active_animation = attributes.anim.death
	death_timer--
	if(death_timer % 2 == 0) image_alpha = 0 else image_alpha = 1
	
	vel.x = 0
	vel.y = 0
	
	if(death_timer <= 0) instance_destroy()
}

if(stun > 0){
	
	active_animation = attributes.anim.death
	stun--
	if(stun == 0)active_animation = attributes.anim.idle
	vel.x = 0
	vel.y = 0
	
}

if(place_meeting(x,y,obj_player) and !ate_player and obj_player.STATE == PlayerState.Default and !dead_af)
{
	if(obj_player.DASH_TIMER > 0 or obj_player.GROUNDPOUNDING)
	{
		dead_af = true
		global.scoreboard.kills++
		death_timer = 60
		audio_play_sound_on(obj_gamemanager.EMITTER_SFX, attributes.sfx_death, false, 0)	
		obj_player.killTauntTimer = 60
		obj_player.enemiesSlainThisDash++
	}
	else if(obj_player.IMMUNITY <= 0 and stun <= 0)
	{
		audio_play_sound_on(obj_gamemanager.EMITTER_SFX, attributes.sfx_capture, false, 0)	
		escape_progress = 0
		ate_player = true
		obj_player.STATE = PlayerState.Hidden
		active_animation = attributes.anim.capture
	}
}

if(ate_player)
{
	obj_view.TARGET = self
	vel.x = 0
	vel.y = 0
	if(global.left_pressed or global.right_pressed){
		escape_progress++
		obj_view.ShakeScreen(.5, 8)
		
		if(escape_progress >= escape_requirement){
			obj_player.STATE = PlayerState.Default
			stun = 120
			ate_player = false
			obj_view.TARGET = obj_player
		}
	}
}

if(ate_player and active_animation == attributes.anim.hold)
{
	churn_timer--
	if(churn_timer <= 0)
	{
		churn_timer = 60
		Churn()
		obj_player.DamageMe(DamageSource.Patroller, 1, true)	
		if(obj_player.STATE == PlayerState.Dead){
			//audio_play_sound_on(obj_gamemanager.EMITTER_SFX, attributes.sfx_digest, false, 0)	
		}
	}
}else churn_timer = 60

if(vel.x > 0) image_xscale = -2
else if(vel.x < 0) image_xscale = 2

move_and_collide(vel.x / 60, vel.y / 60, obj_levelmanager.TILEMAP)

prompt_frame += 10/60