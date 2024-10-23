draw_set_alpha(.75)
draw_set_color(c_black)
draw_rectangle(0,0,window_get_width(), window_get_height(), false)

draw_set_alpha(1)
draw_set_color(c_white)
draw_set_font(font_main)
draw_text_transformed(window_get_width()/2 - 64,window_get_height()/8, "OPTIONS", 2, 2, 0)

var index = 0

if(selected == Option.GameScale and !highlighted) draw_set_color(c_yellow)
else draw_set_color(c_white)
draw_text(100, window_get_height()/8 + 200 + index * 24, "Game Scale")

if(selected == Option.GameScale and highlighted)
{
	draw_set_color(c_yellow)
	draw_text(256, window_get_height()/8 + 200 + index * 24, global.GameScale)
}

index++


if(selected == Option.Fullscreen and !highlighted) draw_set_color(c_yellow)
else draw_set_color(c_white)
draw_text(100, window_get_height()/8 + 200 + index * 24, "Fullscreen")

if(selected == Option.Fullscreen and highlighted)
{
	draw_set_color(c_yellow)
	draw_text(256, window_get_height()/8 + 200 + index * 24, global.options.fullscreen ? "On" : "Off")
}

index++


if(selected == Option.MasterVolume and !highlighted) draw_set_color(c_yellow)
else draw_set_color(c_white)
draw_text(100, window_get_height()/8 + 200 + index * 24, "Master Volume")

if(selected == Option.MasterVolume and highlighted)
{
	draw_set_color(c_yellow)
	draw_text(256, window_get_height()/8 + 200 + index * 24, global.options.volume.master)
}

index++


if(selected == Option.MusicVolume and !highlighted) draw_set_color(c_yellow)
else draw_set_color(c_white)
draw_text(100, window_get_height()/8 + 200 + index * 24, "Music Volume")

if(selected == Option.MusicVolume and highlighted)
{
	draw_set_color(c_yellow)
	draw_text(256, window_get_height()/8 + 200 + index * 24, global.options.volume.music)
}

index++


if(selected == Option.AmbienceVolume and !highlighted) draw_set_color(c_yellow)
else draw_set_color(c_white)
draw_text(100, window_get_height()/8 + 200 + index * 24, "Ambience Volume")

if(selected == Option.AmbienceVolume and highlighted)
{
	draw_set_color(c_yellow)
	draw_text(256, window_get_height()/8 + 200 + index * 24, global.options.volume.ambience)
}

index++


if(selected == Option.SFXVolume and !highlighted) draw_set_color(c_yellow)
else draw_set_color(c_white)
draw_text(100, window_get_height()/8 + 200 + index * 24, "SFX Volume")

if(selected == Option.SFXVolume and highlighted)
{
	draw_set_color(c_yellow)
	draw_text(256, window_get_height()/8 + 200 + index * 24, global.options.volume.sfx)
}

index++


if(selected == Option.Back and !highlighted) draw_set_color(c_yellow)
else draw_set_color(c_white)
draw_text(100, window_get_height()/8 + 200 + index * 24, "Back")

index++


if(room != rm_title)
{
	
	if(selected == Option.QuitToTitle and !highlighted) draw_set_color(c_yellow)
	else draw_set_color(c_white)
	draw_text(100, window_get_height()/8 + 200 + index * 24, "Quit to Title")
	index++
	
	if(selected == Option.QuitGame and !highlighted) draw_set_color(c_yellow)
	else draw_set_color(c_white)
	draw_text(100, window_get_height()/8 + 200 + index * 24, "Quit to Desktop")
	index++

}
else
{
	if(selected == Option.QuitGame and !highlighted) draw_set_color(c_yellow)
	else draw_set_color(c_white)
	draw_text(100, window_get_height()/8 + 200 + index * 24, "Quit to Desktop")
	index++		

}


if(highlighted) draw_sprite(s_ui_options_controlguide_2, 0, window_get_width() - sprite_get_width(s_ui_options_controlguide_2) - 8,window_get_height() - sprite_get_height(s_ui_options_controlguide) - sprite_get_height(s_ui_options_controlguide_2) - 16)

draw_sprite(s_ui_options_controlguide, 0, window_get_width() - sprite_get_width(s_ui_options_controlguide) - 8,window_get_height() - sprite_get_height(s_ui_options_controlguide) - 8)
