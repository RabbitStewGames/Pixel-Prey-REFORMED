ACTIVE_LEVEL = global.level_list[0]

EMITTER_MUSIC = audio_emitter_create()
EMITTER_MUSIC_MUFFLED = audio_emitter_create()
EMITTER_SFX = audio_emitter_create()

audio_emitter_gain(EMITTER_MUSIC, .5)
audio_emitter_gain(EMITTER_MUSIC_MUFFLED, 0)

audio_play_sound_on(EMITTER_MUSIC, ACTIVE_LEVEL.leveldata.music, 0, true)
audio_play_sound_on(EMITTER_MUSIC_MUFFLED, ACTIVE_LEVEL.leveldata.music_muffled, 0, true)

global.acid_height = 0
global.playerhp_max = global.player_list[0].playerdata.hp
global.playerhp = global.playerhp_max

var bg = layer_background_get_id(layer_get_id("Background"))
layer_background_change(bg, ACTIVE_LEVEL.leveldata.background_interior)
layer_background_blend(bg, c_white)
