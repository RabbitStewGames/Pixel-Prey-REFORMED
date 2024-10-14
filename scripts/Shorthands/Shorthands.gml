function draw_text_shadow(x,y, text, xscale, yscale, angle, color)
{
	draw_set_color(c_black)
	draw_text_transformed(x+2,y+2,text,xscale,yscale,angle)	
	
	draw_set_color(color)
	draw_text_transformed(x,y,text,xscale,yscale,angle)	
}