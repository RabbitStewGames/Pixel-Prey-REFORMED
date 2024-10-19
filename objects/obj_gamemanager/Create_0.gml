if(Options_Exists()) Options_Load()
else Options_Init()

EMITTER_MUSIC = audio_emitter_create()
EMITTER_MUSIC_MUFFLED = audio_emitter_create()
EMITTER_SFX = audio_emitter_create()
EMITTER_AMBIENCE = audio_emitter_create()

audio_emitter_gain(EMITTER_MUSIC, global.options.volume.music * global.options.volume.master)
audio_emitter_gain(EMITTER_MUSIC_MUFFLED, 0)
