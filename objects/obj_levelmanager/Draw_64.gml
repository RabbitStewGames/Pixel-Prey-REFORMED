draw_set_alpha(1)
draw_set_color(c_white)

var m =floor(STAGE_TIME/60)
var s = floor(STAGE_TIME mod 60)
var ms = STAGE_TIME-floor(STAGE_TIME)

var s_string = string(s)

if(s < 10) s_string = "0" + s_string

var ms_string = string(ms)
ms_string = string_replace(ms_string, "0.", "")

var timestring = $"{m}:{s_string}.{ms_string}"
draw_text(0,0, timestring)

draw_set_alpha(fadein)
draw_set_color(c_black)
draw_rectangle(0,0,window_get_width(),window_get_height(), false)