draw_set_color(c_white)
draw_set_alpha(1)

if(TAUNTING) draw_sprite_ext(TAUNT_BG, 0, x, y, image_xscale, image_yscale, image_angle, c_white, 1)

if(STATE == PlayerState.Hidden or STATE == PlayerState.Dead) return

if(IMMUNITY <= 0 and JUMPBOOST_TIMER > 0)
	draw_self()
	
if(JUMPBOOST_TIMER <= 0 and JUMPBOOST_TIMER % 2 == 0)
	draw_self()

if(IMMUNITY > 0 and IMMUNITY % 2 == 0)
	draw_self()
	
if(DASH_COOLDOWN > 0)
{
	var percent = DASH_COOLDOWN / GUI_DASH_PUNISHMENT

	var l = x - 48 / 2 + 4
	var r = x + 48 / 2 - 4
	var b = y - 64
	var t = b - 8
	
	var fill = lerp(l,r,percent)

	draw_set_color(c_white)
	
	draw_rectangle(l, b, fill, t, false)
}