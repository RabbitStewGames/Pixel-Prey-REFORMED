// HP

draw_set_font(font_main)
var frame = round(6 * (global.playerhp / global.playerhp_max))
draw_sprite_ext(s_heart, frame, 16, 16, global.GameScale / 2, global.GameScale / 2,0,c_white, 1)

draw_text_shadow(16 * global.GameScale, 16 * global.GameScale, global.playerhp,global.GameScale,global.GameScale,0, c_white)

if(array_length(global.scoreboard.collectibles) > 0)
{
	draw_sprite_ext(collectible_sprite, collectible_frame, 16, 72, global.GameScale, global.GameScale,0,c_white, 1)
	
	draw_text_shadow(24 * global.GameScale, 40 * global.GameScale, array_length(global.scoreboard.collectibles) ,global.GameScale/1.5,global.GameScale/1.5,0, c_white)

}