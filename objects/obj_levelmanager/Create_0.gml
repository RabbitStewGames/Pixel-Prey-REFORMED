audio_stop_all()
 fadein = 1;

ACTIVE_LEVEL = global.level_list[0];

audio_play_sound_on(obj_gamemanager.EMITTER_MUSIC, ACTIVE_LEVEL.leveldata.music, true, 0)
audio_play_sound_on(obj_gamemanager.EMITTER_MUSIC_MUFFLED, ACTIVE_LEVEL.leveldata.music_muffled, true, 0)
audio_play_sound_on(obj_gamemanager.EMITTER_AMBIENCE, ACTIVE_LEVEL.leveldata.ambience, true, 0)


global.acid_height = 0;
global.acid_speed = global.level_list[0].leveldata.acid_speed;
global.playerhp_max = global.player_list[0].playerdata.hp;
global.playerhp = global.playerhp_max;

global.scoreboard = {
	collectibles:[],
	kills:0,
	farthest_stage:0,
	average_time:0.0,
	bonus:0
}

CURRENT_STAGE = 0
STAGE_TIME = 0
TIMES = []

var bg = layer_background_get_id(layer_get_id("Background"))
layer_background_change(bg, ACTIVE_LEVEL.leveldata.background_interior)
layer_background_blend(bg, c_white)

TILEMAP = layer_tilemap_get_id("Tiles_1")
DECORMAP = layer_tilemap_get_id("Tiles_2")

NextStage = function(){
	
	with(obj_collectible){if(!COLLECTED)instance_destroy()}
	with(obj_obstacle){instance_destroy()}
	
	
	CURRENT_STAGE++
	
	
	if(CURRENT_STAGE % 5 == 0) {
		global.acid_speed+= clamp(CURRENT_STAGE/5/2, 0, 2.5)
		
		if(!instance_exists(obj_chatbox_ingame)){
			var cb = instance_create_layer(0,0, "UI", obj_chatbox_ingame)
			cb.MESSAGES = global.level_list[global.ACTIVE_LEVEL].chatdata.ingame.progress[irandom(array_length(global.level_list[global.ACTIVE_LEVEL].chatdata.ingame.progress)-1)]
		}
	}
	
	show_debug_message("Attempting to load stage")
	show_debug_message(array_length(global.level_list[global.ACTIVE_LEVEL].leveldata.stages))
	LoadStage(TILEMAP, DECORMAP, irandom(array_length(global.level_list[global.ACTIVE_LEVEL].leveldata.stages)-1))
	
	obj_player.STATE = PlayerState.Default
	global.acid_height = 0
	obj_acid.y = room_height
	array_push(TIMES, STAGE_TIME)
	STAGE_TIME = 0
	
	obj_player.Unstick()
}

GetAverageTime = function(){
	var avg = 0
	
	for(var i = 0; i < array_length(TIMES); i++)
	{
		avg += TIMES[i]	
	}
	
	avg /= array_length(TIMES)
	
	
	return avg
}

Restart = function(){
	room_restart()
	obj_view.TARGET = obj_player
}

var cb = instance_create_layer(0,0, "UI", obj_chatbox_ingame)
cb.MESSAGES = global.level_list[global.ACTIVE_LEVEL].chatdata.ingame.start[irandom(array_length(global.level_list[global.ACTIVE_LEVEL].chatdata.ingame.start)-1)]


NextStage();