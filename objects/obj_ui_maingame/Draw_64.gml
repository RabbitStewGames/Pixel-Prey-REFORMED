// HP

draw_set_font(font_main)
var frame = round(6 * (global.playerhp / global.playerhp_max))
draw_sprite(s_heart, frame, 16, 16)

draw_text_shadow(38, 32, global.playerhp,1.5,1.5,0, c_white)