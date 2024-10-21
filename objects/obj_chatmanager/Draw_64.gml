var padding = 16
var margin = 16

var rootY = (window_get_height()) - (160 * global.GameScale / 2) - padding * 2

if(MESSAGES[CURRENT_MESSAGE].message != "") 
	draw_sprite_stretched(s_messagebox, -1, padding, rootY + padding, window_get_width() - padding * 2, (160 * global.GameScale / 2))

if(MESSAGES[CURRENT_MESSAGE].expression != "" and MESSAGES[CURRENT_MESSAGE].expression != "none")
{
	var sprite = struct_get(global.level_list[global.ACTIVE_LEVEL].chatdata.expressions, MESSAGES[CURRENT_MESSAGE].expression).image
	show_debug_message(sprite)
	draw_sprite_stretched(sprite, 0, padding + 4, rootY + padding + 4, (180 * global.GameScale / 2) - 8, (160 * global.GameScale / 2) - 8)
	margin += (160 * global.GameScale / 2)
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
	
	draw_sprite(s_messagebox_next, CURSORINDEX, window_get_width() - padding - 24, rootY + 120)
}
