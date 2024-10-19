audio_emitter_gain(EMITTER_SFX, global.options.volume.sfx * global.options.volume.master)
audio_emitter_gain(EMITTER_AMBIENCE, global.options.volume.ambience * global.options.volume.master)

if(room != rm_tummy)
{
	audio_emitter_gain(EMITTER_MUSIC, global.options.volume.music * global.options.volume.master)
	audio_emitter_gain(EMITTER_MUSIC_MUFFLED, 0)
}