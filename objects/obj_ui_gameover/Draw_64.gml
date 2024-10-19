draw_set_color(c_black)
draw_set_alpha(.75)
draw_rectangle(0,0,window_get_width(), window_get_height(), false)

if(doingScoreCount){
	
	var xRoot = global.GameWidth * global.GameScale /2
	var yRoot = global.GameHeight * global.GameScale /2
	
	draw_set_font(font_main)
	draw_set_color(c_white)
	draw_set_alpha(1)
	
	if(scoreCountPhase >= 0)
		draw_text(xRoot, yRoot, $"S: {talliedStages}")
	if(scoreCountPhase >= 1)
		draw_text(xRoot, yRoot + 16, $"T: {talliedAvgTime}")
	if(scoreCountPhase >= 2)
		draw_text(xRoot, yRoot + 32, $"K: {talliedKills}")
	if(scoreCountPhase >= 3 and collectibleSprite != -1){
		draw_sprite(collectibleSprite, collectibleSpriteFrame, xRoot-16, yRoot+48)
		draw_text(xRoot, yRoot + 48, $"C: {talliedCollectibles}")
	}
	
	draw_text(xRoot, yRoot + 64, $"Final Score: {talliedScore}")
}

if(scoreCountFinished)
{
	var xRoot = global.GameWidth * global.GameScale /2
	var yRoot = global.GameHeight * global.GameScale /2
	
	draw_set_font(font_main)
	draw_set_color(c_white)
	draw_set_alpha(1)
	draw_text(xRoot, yRoot + 80, $"Press Space to retry")
	draw_text(xRoot, yRoot + 106, $"Press Escape to quit")
}