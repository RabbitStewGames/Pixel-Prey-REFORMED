var endDialogue = function()
{
	room_goto(rm_tummy)
}

image_xscale = display_get_width() / 64

if(keyboard_check_pressed(vk_escape)) endDialogue()

if(SPECIAL_WAIT > 0) SPECIAL_WAIT--
else
{
	if(CHARS == -1) CHARS = string_length(MESSAGES[CURRENT_MESSAGE].message)

	if(CURRENT_CHAR < CHARS)
	{
		if(mouse_check_button_pressed(mb_left) or keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter))
		{
			for(var i = CURRENT_CHAR + 1; i <= CHARS; i++)
			{
				CURRENT_CHAR = i
				var char = string_char_at(MESSAGES[CURRENT_MESSAGE].message, i)
				if(!array_contains(SPECIAL_CHARS, char)) DRAWN_MESSAGE += char
			}
		}
		else
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
							
							audio_play_sound(global.level_list[global.ACTIVE_LEVEL].leveldata.sfx_talk, 0, false, 1, 0, random_range(.8, 1.2))
							
							break
							
							case "you":
							
							audio_play_sound(global.player_list[0].playerdata.sfx_talk, 1, false, 1, 0, random_range(.8, 1.2))
							
							break
						}
					}
					DO_TEXT_SOUND = !DO_TEXT_SOUND
					
					if(!array_contains(SPECIAL_CHARS, char)) DRAWN_MESSAGE += char
					CHAR_TIMER = CHAR_DELAY
				}
			}
		}
	}
	else
	{
		SCROLL_FINISHED = true	
	}

	if(SCROLL_FINISHED)
	{
		if(ACTION)
		{	
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
		endDialogue();
	}
}