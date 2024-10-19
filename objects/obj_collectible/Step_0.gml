if(!COLLECTED and place_meeting(x,y,obj_player))
{
	COLLECTED = true
	
	X_SCREEN = x - camera_get_view_x(obj_view.CAMERA)
	X_SCREEN *= global.GameScale
	Y_SCREEN = y - camera_get_view_y(obj_view.CAMERA)
	Y_SCREEN *= global.GameScale
	
	audio_play_sound_on(obj_gamemanager.EMITTER_SFX, global.level_list[global.ACTIVE_LEVEL].leveldata.sfx_collect, false, 0, 1, 0, random_range(.8, 1.2))
}

if(COLLECTED){
	spd += 1/60
	X_SCREEN = towards(X_SCREEN, 0, spd)
	Y_SCREEN = towards(Y_SCREEN, 0, spd)	
}

if(X_SCREEN < 16 and Y_SCREEN < 16 and COLLECTED){
	array_push(global.scoreboard.collectibles,COLLECTIBLE)	
	
	if(random(1) > .9) global.playerhp = min(global.playerhp+1,global.playerhp_max)
	
	obj_ui_maingame.collectible_sprite = sprite_index
	obj_ui_maingame.collectible_frame = 0
	
	instance_destroy()
}