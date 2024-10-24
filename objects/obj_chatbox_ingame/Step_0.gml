if(instance_exists(obj_ui_options)) return;

if(!exiting)
{
	boxHeight = round(towards(boxHeight, 128 * global.GameScale / 2, .1))
}
else
{
	boxHeight = floor(towards(boxHeight, 0, .1))
	if(boxHeight == 0) instance_destroy()
}

var endDialogue = function()
{
	exiting = true
}

image_xscale = display_get_width() / 64 - (offset / 64)

if(keyboard_check_pressed(vk_escape)) endDialogue()

if(exiting) return;

if(SPECIAL_WAIT > 0) SPECIAL_WAIT--
else
{
	if(CHARS == -1) CHARS = string_length(MESSAGES[CURRENT_MESSAGE].message)

	if(CURRENT_CHAR < CHARS)
	{
		if(CHAR_TIMER > 0)
		{
			CHAR_TIMER--
		}
		else
		{
			CURRENT_CHAR++
			var char = string_char_at(MESSAGES[CURRENT_MESSAGE].message, CURRENT_CHAR)
			if(char == "*")
			{
				SPECIAL_WAIT = 10
				CHAR_TIMER = CHAR_DELAY
				DO_TEXT_SOUND = true
			}
			else
			{
				if(DO_TEXT_SOUND) 
				{
					switch(MESSAGES[CURRENT_MESSAGE].talksound)
					{
						case "pred":
							
						audio_play_sound_on(obj_gamemanager.EMITTER_SFX, global.level_list[global.ACTIVE_LEVEL].leveldata.sfx_talk, false, 0, 1, 0, random_range(.8, 1.2))
							
						break
							
						case "you":
							
						audio_play_sound_on(obj_gamemanager.EMITTER_SFX, global.player_list[0].playerdata.sfx_talk, false, 0, 1, 0, random_range(.8, 1.2))
							
						break
					}
				}
				DO_TEXT_SOUND = !DO_TEXT_SOUND
					
				if(!array_contains(SPECIAL_CHARS, char)) DRAWN_MESSAGE += char
				CHAR_TIMER = CHAR_DELAY
			}
		}
	}
	else
	{
		SCROLL_FINISHED = true	
	}
	
	if(SCROLL_FINISHED)
	{
		NEXT_TIMER++
		if(NEXT_TIMER > 120)
		{	
			NEXT_TIMER = 0
			CURRENT_MESSAGE++
			DRAWN_MESSAGE = ""
			CURRENT_CHAR = 0
			CHARS = -1
			SCROLL_FINISHED = false
			DO_TEXT_SOUND = true
		}
	}

	if(CURRENT_MESSAGE >= array_length(MESSAGES))
	{
		CURRENT_MESSAGE = array_length(MESSAGES)-1
		endDialogue();
		return
	}
	
}

if(MESSAGES[CURRENT_MESSAGE].expression != "none")
{
	if(SCROLL_FINISHED or SPECIAL_WAIT > 0)
	{
		EXPRESSION_TIMER = 0
		EXPRESSION_FRAME = 0
	}
	else
	{
		if(EXPRESSION_TIMER > 0) EXPRESSION_TIMER--
		else
		{
			var frames = struct_get(global.level_list[global.ACTIVE_LEVEL].chatdata.expressions, MESSAGES[CURRENT_MESSAGE].expression).frames
		
			EXPRESSION_FRAME++
			if(EXPRESSION_FRAME >= frames) EXPRESSION_FRAME = 0
		
			EXPRESSION_TIMER = 5
		}
	}
}