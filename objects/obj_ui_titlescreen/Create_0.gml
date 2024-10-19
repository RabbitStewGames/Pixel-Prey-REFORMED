title_y_offset = 0
subtitle_y_offset = 0
title_rot = 0
sin_period = .00025
sin_amplitude = 10

state = 0

transition_timer = 60
transition_timer_exit = -1

accepting_input = false

audio_stop_all()
audio_play_sound_on(obj_gamemanager.EMITTER_MUSIC, global.titlemusic, true, 0)