if(keyboard_check_pressed(vk_escape) or (keyboard_check_pressed(ord("X")) and !highlighted) or (gamepad_button_check_pressed(0, gp_face2) and !highlighted) or gamepad_button_check_pressed(0, gp_start)) {
	delete_timer = 1
}

if(!highlighted)
{
	if(global.up_pressed){
		if(selected > Option.Top + 1){
			selected--
			audio_play_sound_on(obj_gamemanager.EMITTER_SFX, sfx_cursor, false, 0)
		}
		if(room == rm_title and selected == Option.QuitToTitle) selected--
	}
	if(global.duck_pressed){
		if(selected < Option.QuitGame){
			selected++
			audio_play_sound_on(obj_gamemanager.EMITTER_SFX, sfx_cursor, false, 0)
		}
		if(room == rm_title and selected == Option.QuitToTitle) selected++
	}
	if(global.jump){
		if(selected == Option.Back) delete_timer = 1
		else if(selected == Option.QuitToTitle) room_goto(rm_title)
		else if(selected == Option.QuitGame) game_end()
		else highlighted = true	
		
		audio_play_sound_on(obj_gamemanager.EMITTER_SFX, sfx_select, false, 0)
	}
	if(global.dash){
		delete_timer = 1
		audio_play_sound_on(obj_gamemanager.EMITTER_SFX, sfx_select, false, 0)
	}
}
else
{
	if(global.dash){
		highlighted = false	
		audio_play_sound_on(obj_gamemanager.EMITTER_SFX, sfx_select, false, 0)
	}
	
	if(global.left_pressed)
	{
		audio_play_sound_on(obj_gamemanager.EMITTER_SFX, sfx_cursor, false, 0)
		switch (selected)
		{
			case Option.GameScale:
				UpdateWindow(max(global.GameScale-.25, 2), global.fullscreen)
			break
			case Option.Fullscreen:
				if(global.options.fullscreen) UpdateWindow(global.GameScale, false)
			break
			case Option.MasterVolume:
				global.options.volume.master = max(global.options.volume.master - .1, 0)
			break
			case Option.MusicVolume:
				global.options.volume.music = max(global.options.volume.music - .1, 0)
			break
			case Option.AmbienceVolume:
				global.options.volume.ambience = max(global.options.volume.ambience - .1, 0)
			break
			case Option.SFXVolume:
				global.options.volume.sfx = max(global.options.volume.sfx - .1, 0)
			break
		}
	}
	
	if(global.right_pressed)
	{
		audio_play_sound_on(obj_gamemanager.EMITTER_SFX, sfx_cursor, false, 0)
		switch (selected)
		{
			case Option.GameScale:
				UpdateWindow(min(global.GameScale+.25, 3), global.options.fullscreen)
			break
			case Option.Fullscreen:
				if(!global.options.fullscreen) UpdateWindow(global.GameScale, true)
			break
			case Option.MasterVolume:
				global.options.volume.master = min(global.options.volume.master + .1, 1)
			break
			case Option.MusicVolume:
				global.options.volume.music = min(global.options.volume.music + .1, 1)
			break
			case Option.AmbienceVolume:
				global.options.volume.ambience = min(global.options.volume.ambience + .1, 1)
			break
			case Option.SFXVolume:
				global.options.volume.sfx = min(global.options.volume.sfx + .1, 1)
			break
		}
	}
}


if(delete_timer > 0) delete_timer--
else if(delete_timer==0){
	Options_Save()
	instance_destroy()
}