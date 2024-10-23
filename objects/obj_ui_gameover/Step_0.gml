image_alpha += 1/60

if(doingFailAnimation)
{
	if(failAnimationTimer > 0) failAnimationTimer--
	else
	{
		doingScoreCount = true	
		doingFailAnimation = false
	}
	
}

if(failAnimFrameTimer > 0) failAnimFrameTimer--
	else
	{
		failAnimFrameTimer = 15
		failAnimFrame++
		
		if(failAnimFrame >= fail_animation.frames) failAnimFrame = 0
	}

if(doingScoreCount and !scoreCountFinished)
{
	actionTimer--
	
	if(actionTimer<=0)
	{
	
	switch(scoreCountPhase)
	{
		case 0: // Stages
		
			if(global.scoreboard.farthest_stage > 10)
			{ 
				global.scoreboard.farthest_stage -= 10
				talliedStages += 10
				talliedScore += score_per_stage * 10
				actionTimer = 5
				
				audio_play_sound_on(obj_gamemanager.EMITTER_SFX, sfx_blip, false, 0, 1, 0, sfxpitch)
				sfxpitch += .1
			} 
			else if(global.scoreboard.farthest_stage > 0)
			{
				global.scoreboard.farthest_stage--
				talliedStages++
				talliedScore += score_per_stage
				
				audio_play_sound_on(obj_gamemanager.EMITTER_SFX, sfx_blip, false, 0, 1, 0, sfxpitch)
				sfxpitch += .1
				
				actionTimer = 5
			}
			else if(global.scoreboard.farthest_stage == 0)
				{
					actionTimer = 30
					scoreCountPhase++
					sfxpitch = 1
				}
		
		break
		
		case 1: // Time
		
			if(talliedAvgTime < global.scoreboard.average_time or global.scoreboard.average_time == 0)
			{ 
				if(global.scoreboard.average_time == 0){
					actionTimer = 30
					scoreCountPhase++
					global.scoreboard.average_time = -1
					sfxpitch = 1
				}
				else
				{
					talliedAvgTime = towards(talliedAvgTime, global.scoreboard.average_time, .1)
					
					if(abs(talliedAvgTime - global.scoreboard.average_time) < .5) 
					{
						talliedAvgTime = global.scoreboard.average_time
						talliedScore += floor(time_score / talliedAvgTime)
						actionTimer = 30
						scoreCountPhase++
						sfxpitch = 1
					}
				}
			}
		
		break
		
		case 2:// Kills
		
			if(global.scoreboard.kills > 10)
			{ 
				global.scoreboard.kills -= 10
				talliedKills += 10
				talliedScore += score_per_kill * 10
				actionTimer = 5
				audio_play_sound_on(obj_gamemanager.EMITTER_SFX, sfx_blip, false, 0, 1, 0, sfxpitch)
				sfxpitch += .1
			} 
			else if(global.scoreboard.kills > 0)
			{
				global.scoreboard.kills--
				talliedKills ++
				talliedScore += score_per_kill
				audio_play_sound_on(obj_gamemanager.EMITTER_SFX, sfx_blip, false, 0, 1, 0, sfxpitch)
				sfxpitch += .1
					
				actionTimer = 5
			}
			else if(global.scoreboard.kills == 0)
			{
				actionTimer = 30
				scoreCountPhase++
				sfxpitch = 1
			}
		
		break
		
		case 3: // Collectibles
		
			if(array_length(global.scoreboard.collectibles) > 0)
			{ 
				collectibleSprite = global.scoreboard.collectibles[0].image
				talliedCollectibles++
				talliedScore += global.scoreboard.collectibles[0].value
				audio_play_sound_on(obj_gamemanager.EMITTER_SFX, sfx_blip, false, 0, 1, 0, sfxpitch)
				sfxpitch += .05
				array_pop(global.scoreboard.collectibles)
						
				if(array_length(global.scoreboard.collectibles) == 0){
					actionTimer = 30
					scoreCountPhase++
					sfxpitch = 1
				}
				else if(talliedCollectibles < 50)
					actionTimer = 2
				else if(talliedCollectibles < 100)
					actionTimer = 1
				else
					actionTimer = 0
			}
			else 
			{
				scoreCountPhase++
			}
		
			break
			
			case 4:
			
				scoreCountFinished = true
			
			break
		}
		
		
	}
}

if(collectibleSprite != -1)
{
	collectibleSpriteFrame += 10/60
	if(collectibleSpriteFrame > sprite_get_number(collectibleSprite)) collectibleSpriteFrame = 0
}

sfxpitch = min(sfxpitch, 1.75)

if(scoreCountFinished)
{
	if(keyboard_check_pressed(vk_space)) obj_levelmanager.Restart()
	if(keyboard_check(vk_escape)) room_goto(rm_title)
}