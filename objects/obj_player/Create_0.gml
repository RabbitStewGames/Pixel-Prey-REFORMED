event_inherited()

DATA = global.player_list[0]

sprite_index = DATA.playerdata.sprite
mask_index = DATA.playerdata.mask

image_speed = 0

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

ANIM_DELAY = 5
ANIM_TIMER = 0
ANIM_FRAME = 0

DASH_TIMER = 0
DASH_COOLDOWN = 0
DASH_PUNISHMENT = 0

LOOKDOWN_TIMER = 180
LOOKUP_TIMER = 180

GROUNDPOUNDING = false

IMMUNITY = 0

STEP_HEIGHT = 4

SUBMERGED = false
SUBMERGED_OLD = SUBMERGED

LEFT = keyboard_check(global.keymap.left)
RIGHT = keyboard_check(global.keymap.right)
UP = keyboard_check(global.keymap.up)
DOWN = keyboard_check(global.keymap.duck)
JUMP = keyboard_check_pressed(global.keymap.jump)
DASH = keyboard_check_pressed(global.keymap.dash)

X_OLD = x
Y_OLD = y

JUMPBOOST_TIMER = 30

SFX_JUMP = global.player_list[0].playerdata.sfx_jump
SFX_DASH = global.player_list[0].playerdata.sfx_dash
SFX_DEATH = global.player_list[0].playerdata.sfx_death
SFX_SPLASH = global.player_list[0].playerdata.sfx_splash
SFX_SWIM = global.player_list[0].playerdata.sfx_swim

DamageMe = function(src, amt)
{
	if(IMMUNITY <= 0){
		global.playerhp = max(global.playerhp-amt, 0)
	
		if(global.playerhp == 0) OnDeath(src)
		
		IMMUNITY = 120 * amt
	}
}

OnDeath = function(src)
{
	// TODO player death
}

enum DamageSource
{
	Generic,
	Acid
}

isfree = function(_x,_y)
{
	return !place_meeting(_x, _y, [obj_clip, TILEMAP])
}