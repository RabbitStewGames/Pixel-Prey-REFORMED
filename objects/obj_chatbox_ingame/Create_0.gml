MESSAGES = []
DRAWN_MESSAGE = ""

CHAR_DELAY = 1
SCROLL_FINISHED = false
CURRENT_CHAR = 0
CURRENT_MESSAGE = 0
CHARS = -1
CHAR_TIMER = 0

CURSORDELAY = 5
CURSORTIMER = 0
CURSORINDEX = 0

SPECIAL_CHARS = [ "*" ]
SPECIAL_WAIT = 0

DO_TEXT_SOUND = true

EXPRESSION_FRAME = 0
EXPRESSION_TIMER = 0

offset = 64 * global.GameScale
NEXT_TIMER = 0

boxHeight = 0
exiting = false

audio_play_sound_on(obj_gamemanager.EMITTER_SFX, sfx_chatbox_open, false, 0)