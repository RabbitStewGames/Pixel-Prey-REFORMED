function draw_text_shadow(x,y, text, xscale, yscale, angle, color)
{
	draw_set_color(c_black)
	draw_text_transformed(x+2,y+2,text,xscale,yscale,angle)	
	
	draw_set_color(color)
	draw_text_transformed(x,y,text,xscale,yscale,angle)	
}

function Churn()
{
	var churns = [
		sfx_churn_1,
		sfx_churn_2,
		sfx_churn_3,
		sfx_churn_4,
		sfx_churn_5
	]
	
	audio_play_sound_on(obj_gamemanager.EMITTER_SFX, churns[irandom(array_length(churns)-1)], false, 0)
}