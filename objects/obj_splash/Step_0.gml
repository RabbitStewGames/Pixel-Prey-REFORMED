if(STAGE == 1 and FADE_TIMER > 100 and FADE_TIMER < 110)
	x_offset = sin(current_time * .25) * 5
else
	x_offset = 0

if(FADEOUT)
	ALPHA = max(0, ALPHA - FADE_SPEED / 60)
else
	ALPHA = min(1, ALPHA + FADE_SPEED / 60)

if((FADEOUT and ALPHA == 0) or(!FADEOUT and ALPHA == 1))
{
	FADE_TIMER--
}
else
{
	if(FADEOUT)
	FADE_TIMER = 60
	else
	FADE_TIMER = 180
}

if(FADE_TIMER==0)
{
	if(FADEOUT)
		STAGE++
	FADEOUT = !FADEOUT
	
	if(FADEOUT)
	FADE_TIMER = 60
	else
	FADE_TIMER = 180
	
	if(STAGE > 1) room_goto(rm_title)
}

if(STAGE == 0) sprite_index = s_splash_cinna
if(STAGE == 1) sprite_index = s_splash_duke1
if(STAGE == 1 and FADE_TIMER > 100 and FADE_TIMER < 110) {
	sprite_index = s_splash_duke2
	
	if(random(1) > .75){
		if(colorblend == c_white)
			colorblend = c_black
		else colorblend = c_white
	}
}
else
colorblend = c_white

if(global.jump or keyboard_check(vk_escape) or keyboard_check(vk_enter) or mouse_check_button(mb_left))
	room_goto(rm_title)
	
if(STAGE == 0 and CINNA_ANIMATE == true and ALPHA == 1){
	FRAME_CINNA += 10/60
	image_index = FRAME_CINNA
	if(FRAME_CINNA > sprite_get_number(sprite_index))
	{
		CINNA_ANIMATE = false
	}
}
else FRAME_CINNA = 0