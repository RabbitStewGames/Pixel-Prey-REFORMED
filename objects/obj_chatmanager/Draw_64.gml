var padding = 16
var margin = 16

var rootY = window_get_height() - 128 - padding * 2

if(MESSAGES[CURRENT_MESSAGE].message != "") draw_sprite_stretched(s_messagebox, -1, padding, rootY + padding, window_get_width() - padding * 2, 128)
draw_set_color(c_white)
draw_set_font(font_main)
draw_text_ext(margin+padding, rootY+margin+padding, DRAWN_MESSAGE, 24, window_get_width() - padding * 2 - margin * 2)

if(SCROLL_FINISHED)
{
	if(CURSORTIMER > 0) CURSORTIMER--
	else
	{
		CURSORTIMER = CURSORDELAY
		CURSORINDEX++
		
		if(CURSORINDEX >= 7) CURSORINDEX = 0
	}
	
	draw_sprite(s_messagebox_next, CURSORINDEX, window_get_width() - padding - 5, rootY + 128)
}
