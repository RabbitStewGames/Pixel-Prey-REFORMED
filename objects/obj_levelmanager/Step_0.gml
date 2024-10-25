if(obj_player.SUBMERGED or instance_exists(obj_ui_gameover))
{
	audio_emitter_gain(obj_gamemanager.EMITTER_MUSIC, lerp(audio_emitter_get_gain(obj_gamemanager.EMITTER_MUSIC), 0, 0.1))
	audio_emitter_gain(obj_gamemanager.EMITTER_MUSIC_MUFFLED, lerp(audio_emitter_get_gain(obj_gamemanager.EMITTER_MUSIC_MUFFLED), global.options.volume.music * global.options.volume.master, 0.1))
}
else
{
	audio_emitter_gain(obj_gamemanager.EMITTER_MUSIC, lerp(audio_emitter_get_gain(obj_gamemanager.EMITTER_MUSIC), global.options.volume.music * global.options.volume.master, 0.1))
	audio_emitter_gain(obj_gamemanager.EMITTER_MUSIC_MUFFLED, lerp(audio_emitter_get_gain(obj_gamemanager.EMITTER_MUSIC_MUFFLED), 0, 0.1))
}

if(!instance_exists(obj_ui_options) and !instance_exists(obj_stagetransition) and !instance_exists(obj_ui_gameover))
	STAGE_TIME += 1/fps
	
	
 if(fadein > 0) fadein -= 1/60