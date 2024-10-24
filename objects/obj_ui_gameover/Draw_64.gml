draw_set_alpha(image_alpha)

var go_xRoot = 77 * 2 * global.GameScale + failXOffset * global.GameScale
var go_yRoot = 12 * 2 * global.GameScale

draw_sprite_stretched(fail_animation.image, failAnimFrame, go_xRoot, go_yRoot, 166 * global.GameScale * 2, 117 * global.GameScale * 2)
draw_sprite_stretched(s_gameover_fg, 0, failXOffset * global.GameScale, 0, global.GameWidth * global.GameScale, global.GameHeight * global.GameScale)
draw_set_color(c_black)
draw_rectangle(0,0,failXOffset * global.GameScale, window_get_height(), false)
var textScale = 1

var xRoot = 24
var yRoot = global.GameHeight * global.GameScale / 8

var textPadding = 16 * global.GameScale
	
if(doingScoreCount){
	
	//draw_set_color(c_black)
	//draw_set_alpha(.5)
	//draw_rectangle(0,0,window_get_width(), window_get_height(), false)
	
	
	
	draw_set_font(font_main)
	draw_set_color(c_white)
	draw_set_alpha(1)
	
	if(scoreCountPhase >= 0)
		draw_text_transformed(xRoot, yRoot, $"S: {talliedStages}", textScale * global.GameScale, textScale * global.GameScale, 0)
	if(scoreCountPhase >= 1)
		draw_text_transformed(xRoot, yRoot + 16 * textScale + textPadding, $"T: {talliedAvgTime}", textScale * global.GameScale, textScale * global.GameScale, 0)
	if(scoreCountPhase >= 2)
		draw_text_transformed(xRoot, yRoot + 32 * textScale + textPadding * 2, $"K: {talliedKills}", textScale * global.GameScale, textScale * global.GameScale, 0)
	if(scoreCountPhase >= 3 and collectibleSprite != -1){
		draw_sprite_ext(collectibleSprite, collectibleSpriteFrame, xRoot, yRoot + 48 * textScale + textPadding * 3, textScale * global.GameScale, textScale * global.GameScale, 0, c_white, 1)
		draw_text_transformed(xRoot + 16 * textScale * 2, yRoot + 48 * textScale + textPadding * 3, $"C: {talliedCollectibles}", textScale * global.GameScale, textScale * global.GameScale, 0)
	}
	
	draw_set_color(c_yellow)
	draw_text_transformed(xRoot, yRoot + 64 * textScale + textPadding * 4, $"Final Score: {talliedScore}", textScale * global.GameScale, textScale * global.GameScale, 0)
}

if(scoreCountFinished)
{
	draw_set_font(font_main)
	draw_set_color(c_white)
	draw_set_alpha(1)
	draw_text_transformed(xRoot, yRoot + 120 * textScale + textPadding * 5, $"Press Space to retry", textScale * global.GameScale, textScale * global.GameScale, 0)
	draw_text_transformed(xRoot, yRoot + 144 * textScale + textPadding * 6, $"Press Escape to quit", textScale * global.GameScale, textScale * global.GameScale, 0)
}