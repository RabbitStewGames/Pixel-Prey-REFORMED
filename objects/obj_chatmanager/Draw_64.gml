var padding = 16
var margin = 16

var boxHeight = (160 * global.GameScale / 2)

var rootY = (window_get_height()) - boxHeight - padding * 2

draw_set_alpha(1)


if(MESSAGES[CURRENT_MESSAGE].message != "") 
	draw_sprite_stretched(s_messagebox, -1, padding, rootY + padding, window_get_width() - padding * 2, boxHeight)

if(MESSAGES[CURRENT_MESSAGE].expression != "" and MESSAGES[CURRENT_MESSAGE].expression != "none")
{
	var sprite = struct_get(global.level_list[global.ACTIVE_LEVEL].chatdata.expressions, MESSAGES[CURRENT_MESSAGE].expression).image
	draw_sprite_stretched(sprite, EXPRESSION_FRAME, padding + 4, rootY + padding + 4, boxHeight - 8, boxHeight - 8)
	margin += boxHeight
}

if(MESSAGES[CURRENT_MESSAGE].message != "") 
{
	draw_set_color(c_white)
	draw_set_font(font_main)
	
	draw_text_ext_transformed(margin+padding, rootY+padding*2, DRAWN_MESSAGE, 24, (window_get_width() - padding * 2 - margin * 2)/(global.GameScale/1.5), global.GameScale/1.5,global.GameScale/1.5,0)
}

if(SCROLL_FINISHED)
{
	if(CURSORTIMER > 0) CURSORTIMER--
	else
	{
		CURSORTIMER = CURSORDELAY
		CURSORINDEX++
		
		if(CURSORINDEX >= 7) CURSORINDEX = 0
	}
	
	draw_sprite(s_messagebox_next, CURSORINDEX, window_get_width() - padding - 24, rootY + boxHeight)
}

draw_set_alpha(EXIT_FADE)
draw_set_color(c_black)
draw_rectangle(0,0,window_get_width(), window_get_height(), false)