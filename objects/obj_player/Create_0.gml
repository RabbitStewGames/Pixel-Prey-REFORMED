event_inherited()

DATA = global.player_list[0]

sprite_index = DATA.playerdata.sprite
mask_index = DATA.playerdata.mask

sprite_set_speed(sprite_index, 10, spritespeed_framespersecond)

MOVE_SPEED = DATA.playerdata.move_speed
JUMP_HEIGHT = DATA.playerdata.jump_height

COYOTE_TIME = 0
FRICTION = DATA.playerdata.friction

TILEMAP = layer_tilemap_get_id("Tiles_1")

VEL = new Vector2(0,0)
GROUNDED = true
GROUNDED_OLD = GROUNDED
GRAVITY = 10

DIRECTION = 1

JUMP_DELAY = DATA.playerdata.jump_delay * sprite_get_speed(sprite_index)
JUMP_TIMER = 0
JUMPING = false

BONK_DELAY = DATA.playerdata.bonk_delay * sprite_get_speed(sprite_index)
BONK_TIMER = 0

ANIM_IDLE = DATA.playerdata.anim_idle
ANIM_RUN = DATA.playerdata.anim_run
ANIM_QUICKTURN = DATA.playerdata.anim_quickturn
ANIM_STOP = DATA.playerdata.anim_stop
ANIM_JUMP = DATA.playerdata.anim_jump
ANIM_MIDAIR_UP = DATA.playerdata.anim_midair_up
ANIM_MIDAIR_DOWN = DATA.playerdata.anim_midair_down
ANIM_BONK = DATA.playerdata.anim_bonk
ANIM_LAND = DATA.playerdata.anim_land
ANIM_SLOWTURN = DATA.playerdata.anim_slowturn
ANIM_CROUCH_BEGIN =  DATA.playerdata.anim_crouch_begin
ANIM_CROUCH_IDLE =  DATA.playerdata.anim_crouch_idle
ANIM_CRAWL =  DATA.playerdata.anim_crawl
ANIM_CROUCH_END =  DATA.playerdata.anim_crouch_end
ANIM_SWIM_UP =  DATA.playerdata.anim_swim_up
ANIM_SWIM_DOWN =  DATA.playerdata.anim_swim_down
ANIM_STUN =  DATA.playerdata.anim_stun

LOCK_ANIMATION = false
ACTIVE_ANIMATION = ANIM_IDLE

DASH_TIMER = 0
DASH_COOLDOWN = 0
DASH_PUNISHMENT = 0
GUI_DASH_PUNISHMENT = 0

LOOKUP_TIMER = 180

GROUNDPOUNDING = false

IMMUNITY = 0

STEP_HEIGHT = 4

SUBMERGED = false
SUBMERGED_OLD = SUBMERGED

LEFT = keyboard_check(global.options.keymap.left)
RIGHT = keyboard_check(global.options.keymap.right)
UP = keyboard_check(global.options.keymap.up)
DOWN = keyboard_check(global.options.keymap.duck)
JUMP = keyboard_check_pressed(global.options.keymap.jump)
DASH = keyboard_check_pressed(global.options.keymap.dash)
DOWN_OLD = DOWN
LEFT_OLD = LEFT
RIGHT_OLD = RIGHT

X_OLD = x
Y_OLD = y

JUMPBOOST_TIMER = 30

SFX_JUMP = global.player_list[0].playerdata.sfx_jump
SFX_DASH = global.player_list[0].playerdata.sfx_dash
SFX_DEATH = global.player_list[0].playerdata.sfx_death
SFX_SPLASH = global.player_list[0].playerdata.sfx_splash
SFX_SWIM = global.player_list[0].playerdata.sfx_swim
SFX_BONK = global.player_list[0].playerdata.sfx_bonk
SFX_FOOTSTEPS = global.player_list[0].playerdata.sfx_footsteps
SFX_SLIDE = global.player_list[0].playerdata.sfx_slide
SFX_LAND = global.player_list[0].playerdata.sfx_land

DeathTimer = 0


enum PlayerState 
{
	Default,
	Disabled,
	Hidden,
	Dead
}

STATE = PlayerState.Default

FOOTSTEP_TIMER = 0
FOOTSTEP_DELAY = 15

DamageMe = function(src, amt, ignore_immunity = false)
{
	if(IMMUNITY <= 0 or ignore_immunity){
		global.playerhp = max(global.playerhp-amt, 0)
	
		if(global.playerhp == 0) OnDeath(src)
		
		IMMUNITY = 120 * amt
	}
}

OnDeath = function(src)
{
	STATE = PlayerState.Dead
	DeathTimer = 60
}

enum DamageSource
{
	Generic,
	Acid,
	Chaser,
}

isfree = function(_x,_y)
{
	return !place_meeting(_x, _y, [obj_clip, TILEMAP])
}