var padding = 16
var margin = 16

//var boxHeight = (128 * global.GameScale / 2)
var boxWidth = (1024 * global.GameScale / 2)

var rootY = padding * 2

if(MESSAGES[CURRENT_MESSAGE].message != "") 
	draw_sprite_stretched(s_messagebox, -1, offset + padding, rootY + padding, boxWidth - padding * 2, boxHeight)

if(MESSAGES[CURRENT_MESSAGE].expression != "" and MESSAGES[CURRENT_MESSAGE].expression != "none")
{
	var sprite = struct_get(global.level_list[global.ACTIVE_LEVEL].chatdata.expressions, MESSAGES[CURRENT_MESSAGE].expression).image
	draw_sprite_stretched(sprite, EXPRESSION_FRAME, offset + padding + 4, rootY + padding + 4, (128 * global.GameScale / 2) - 8, boxHeight - 8)
	margin += boxHeight
}

if(MESSAGES[CURRENT_MESSAGE].message != "") 
{
	draw_set_color(c_white)
	draw_set_font(font_main)
	
	draw_text_ext_transformed(offset + margin + padding, rootY+padding*2, DRAWN_MESSAGE, 24, (boxWidth - padding * 2 - margin * 2)/(global.GameScale/1.5), global.GameScale/1.5,global.GameScale/1.5,0)
}