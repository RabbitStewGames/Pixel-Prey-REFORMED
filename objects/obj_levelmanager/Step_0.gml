if(obj_player.SUBMERGED)
{
	audio_emitter_gain(EMITTER_MUSIC, lerp(audio_emitter_get_gain(EMITTER_MUSIC), 0, 0.1))
	audio_emitter_gain(EMITTER_MUSIC_MUFFLED, lerp(audio_emitter_get_gain(EMITTER_MUSIC_MUFFLED), .5, 0.1))
}
else
{
	audio_emitter_gain(EMITTER_MUSIC, lerp(audio_emitter_get_gain(EMITTER_MUSIC), .5, 0.1))
	audio_emitter_gain(EMITTER_MUSIC_MUFFLED, lerp(audio_emitter_get_gain(EMITTER_MUSIC_MUFFLED), 0, 0.1))
}