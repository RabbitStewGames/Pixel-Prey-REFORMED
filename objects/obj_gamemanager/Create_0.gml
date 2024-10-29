if(Options_Exists()) Options_Load()
else Options_Init()

EMITTER_MUSIC = audio_emitter_create()
EMITTER_MUSIC_MUFFLED = audio_emitter_create()
EMITTER_SFX = audio_emitter_create()
EMITTER_AMBIENCE = audio_emitter_create()

audio_emitter_gain(EMITTER_MUSIC, global.options.volume.music * global.options.volume.master)
audio_emitter_gain(EMITTER_MUSIC_MUFFLED, 0)

global.left = false
global.right = false
global.up = false
global.duck = false
global.jump = false
global.dash = false

global.left_pressed = false
global.right_pressed = false
global.up_pressed = false
global.duck_pressed = false
global.lhBlock = false
global.lvBlock = false
