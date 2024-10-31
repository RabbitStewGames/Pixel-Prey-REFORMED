gml_pragma("global", "LoadContent()")

function LoadContent()
{
	
	global.ResourcePath = $"{program_directory}resources"
	
	global.level_list = []
	global.player_list = []
	
	global.titlemusic = LoadSound($"{global.ResourcePath}/mus_titlescreen.ogg")
	global.titlescreen = LoadImage($"{global.ResourcePath}/titlescreen.png")
	
	if(directory_exists(global.ResourcePath))
	{
		// ==== LOAD LEVELS ==== //
		
		if(directory_exists($"{global.ResourcePath}/levels"))
		{
			// Gather directories

			var folders = []		
			var folder_name = file_find_first($"{global.ResourcePath}/levels/*", fa_directory);

			while (folder_name != "")
			{
			    array_push(folders, folder_name);

			    folder_name = file_find_next();
			}

			file_find_close();
		
			// Read character attributes of each directory.
		
			for(var i = 0; i < array_length(folders); i++)
			{
				if(file_exists($"{global.ResourcePath}/levels/{folders[i]}/attributes.json"))
				{
					var file = file_text_open_read($"{global.ResourcePath}/levels/{folders[i]}/attributes.json")
					try
					{
						var contents = file_text_read_string(file)
				
						var attributes = json_parse(contents)
				
						var leveldata = new LevelData(attributes, folders[i])
					
						if(leveldata != -1) // Prevent adding an invalid level to levellist
							array_push(global.level_list, leveldata)
						
						file_text_close(file)
					}
					catch(_exception)
					{
						file_text_close(file)
						
						show_debug_message($"ERROR while attempting to load level {global.ResourcePath}/levels/{folders[i]}:");
						show_debug_message(_exception.message);
					    show_debug_message(_exception.longMessage);
					    show_debug_message(_exception.script);
					    show_debug_message(_exception.stacktrace);
					}
				}
			}
		
			global.ACTIVE_LEVEL = 0
		}
		else
			show_message($"Levels folder not found! {global.ResourcePath}/levels")
			
		if(directory_exists($"{global.ResourcePath}/players"))
		{
			// Gather directories

			var folders = []		
			var folder_name = file_find_first($"{global.ResourcePath}/players/*", fa_directory);

			while (folder_name != "")
			{
			    array_push(folders, folder_name);

			    folder_name = file_find_next();
			}

			file_find_close();
			
			for(var i = 0; i < array_length(folders); i++)
			{
				if(file_exists($"{global.ResourcePath}/players/{folders[i]}/attributes.json"))
				{
					var file = file_text_open_read($"{global.ResourcePath}/players/{folders[i]}/attributes.json")
					var contents = file_text_read_string(file)
				
					var attributes = json_parse(contents)
				
					var playerdata = new PlayerData(attributes, folders[i])
				
					array_push(global.player_list, playerdata)
					file_text_close(file)
				}
			}
		}
		else
			show_message($"Players folder not found!")
	}
	else 
		show_message($"Resources folder not found!")
}

enum LoadStatus{
	Successful,
	ResourcesFolderMissing,
	LevelsFolderMissing,
	PlayersFolderMissing
}

function LevelData(_data, _folder) constructor
{
	leveldata = LevelData.Parse(_data, _folder)
	chatdata = LevelData.GetChatData(_folder)

	static Parse = function(data, folder)
	{
		try
		{
			var levelfolder = folder
			var _levelname = data.leveldata.levelname
			var _predname = data.leveldata.predname
		
			var _s_acid = LoadImage($"{global.ResourcePath}/levels/{levelfolder}/images/acid.png", data.images.acid_frames)
			var _background_interior = LoadImage($"{global.ResourcePath}/levels/{levelfolder}/images/bg_interior.png")
			
			var _stages = []
			
			var img_name = file_find_first($"{global.ResourcePath}/levels/{levelfolder}/progen/*", fa_none);

			while (img_name != "")
			{
				if(string_ends_with(img_name, ".png"))
				{
					//show_debug_message(img_name)
					var img = LoadImage($"{global.ResourcePath}/levels/{levelfolder}/progen/{img_name}")
					//show_debug_message(img)
					array_push(_stages, img);
				}
			    img_name = file_find_next();
			}

			file_find_close();
			
			// show_debug_message(_stages)
			
			
			var __collectibles = data.leveldata.collectibles
			var _collectibles = []
			
			for(var i = 0; i < array_length(__collectibles); i++)
			{
				var c = {
					image: LoadImage($"{global.ResourcePath}/levels/{levelfolder}/images/{__collectibles[i].image}", __collectibles[i].frames),
					value: __collectibles[i].value
				}
				
				array_push(_collectibles, c)
			}
			
			
			
			var __gameovers = data.gameovers
			var _gameovers = []
			
			for(var i = 0; i < array_length(__gameovers); i++)
			{
				var g = {
					image: LoadImage($"{global.ResourcePath}/levels/{levelfolder}/images/{__gameovers[i].image}", __gameovers[i].frames),
					frames: __gameovers[i].frames
				}
				
				array_push(_gameovers, g)
			}
			
			
			
			var _chaser = -1
			
			if(directory_exists($"{global.ResourcePath}/levels/{levelfolder}/obstacle/chaser")){
				
				var file = file_text_open_read($"{global.ResourcePath}/levels/{levelfolder}/obstacle/chaser/attributes.json")
				var contents = file_text_read_string(file)
				var d = json_parse(contents)
				
				var c = {
					image: LoadImage($"{global.ResourcePath}/levels/{levelfolder}/obstacle/chaser/main_sprite.png",d.framecount),
					mask: LoadImage($"{global.ResourcePath}/levels/{levelfolder}/obstacle/chaser/mask.png"),
					framerate: d.framerate,
					framecount: d.framecount,
					move_speed: d.move_speed,
					solid: d.solid,
					anim:{
						idle: d.anim.idle,
						capture: d.anim.capture,
						hold: d.anim.hold,
						death: d.anim.death
					},
					sfx_digest: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/obstacle/chaser/digest.ogg"),
					sfx_death: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/obstacle/chaser/death.ogg"),
					sfx_aggro: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/obstacle/chaser/aggro.ogg"),
					sfx_capture: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/obstacle/chaser/capture.ogg"),
				}
				
				file_text_close(file)
				
				_chaser = c
			}
			
			var _patroller = -1
			
			if(directory_exists($"{global.ResourcePath}/levels/{levelfolder}/obstacle/patroller")){
				
				var file = file_text_open_read($"{global.ResourcePath}/levels/{levelfolder}/obstacle/patroller/attributes.json")
				var contents = file_text_read_string(file)
				var d = json_parse(contents)
				
				var p = {
					image: LoadImage($"{global.ResourcePath}/levels/{levelfolder}/obstacle/patroller/main_sprite.png",d.framecount),
					mask: LoadImage($"{global.ResourcePath}/levels/{levelfolder}/obstacle/patroller/mask.png"),
					framerate: d.framerate,
					framecount: d.framecount,
					move_speed: d.move_speed,
					anim:{
						idle: d.anim.idle,
						move: d.anim.move,
						capture: d.anim.capture,
						hold: d.anim.hold,
						death: d.anim.death
					},
					sfx_death: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/obstacle/patroller/death.ogg"),
					sfx_capture: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/obstacle/patroller/capture.ogg"),
				}
				
				file_text_close(file)
				
				_patroller = p
			}
			
			
			
			var output = {
				directory: levelfolder,
				levelname: _levelname,
				predname: _predname,
				gameovers: _gameovers,
				music: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/audio/music.ogg"),
				music_muffled: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/audio/music_muffled.ogg"),
				ambience: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/audio/ambience.ogg"),
				s_acid: _s_acid,
				s_goal: LoadImage($"{global.ResourcePath}/levels/{levelfolder}/images/goal.png"),
				acid_speed: data.leveldata.acid_speed,
				acid_color: data.images.acid_color,
				acid_alpha: data.images.acid_alpha,
				ambient_light: data.images.ambient_light,
				background_interior: _background_interior,
				sfx_talk: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/audio/talk.ogg"),
				sfx_collect: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/audio/collectible.ogg"),
				stages: _stages,
				collectibles: _collectibles,
				chaser:_chaser,
				patroller:_patroller,
			}
			
			// show_debug_message(output.stages)
			return output
		}
		catch(_exception)
		{
			show_debug_message(_exception.message);
		    show_debug_message(_exception.longMessage);
		    show_debug_message(_exception.script);
		    show_debug_message(_exception.stacktrace);
			
			return -1
		}
	}
	
	static GetChatData = function(folder)
	{
		var file = file_text_open_read($"{global.ResourcePath}/levels/{folder}/chat.json")
					
		var contents = file_text_read_string(file)
				
		var d = json_parse(contents)
				
		file_text_close(file)
		
		var cd = new ChatData(d, folder)
		
		return cd
	}
	
}

function PlayerData(_data, _folder) constructor{

	playerdata = PlayerData.Parse(_data, _folder);

	static Parse = function(data, folder)
	{
		var imgCount = data.anim_frames
		var strip = LoadImage($"{global.ResourcePath}/players/{folder}/main_sprite.png",imgCount)
		sprite_set_offset(strip, sprite_get_width(strip) / 2, sprite_get_height(strip))
		var _taunt_bg = LoadImage($"{global.ResourcePath}/players/{folder}/taunt_bg.png")
		sprite_set_offset(_taunt_bg, sprite_get_width(_taunt_bg) / 2, sprite_get_height(_taunt_bg))
		var _mask = LoadImage($"{global.ResourcePath}/players/{folder}/mask.png")
		sprite_set_offset(_mask, sprite_get_width(_mask) / 2, sprite_get_height(_mask))
		
		var _steps = []
			
			var s_name = file_find_first($"{global.ResourcePath}/players/{folder}/footsteps/*", fa_none);

			while (s_name != "")
			{
				if(string_ends_with(s_name, ".ogg"))
				{
					var s = LoadSound($"{global.ResourcePath}/players/{folder}/footsteps/{s_name}")
				
					array_push(_steps, s);
				}
			    s_name = file_find_next();
			}

			file_find_close();
		
		
		var output = {
			playerfolder: folder,
			name: data.name,
			move_speed: data.move_speed,
			jump_height: data.jump_height,
			sprite: strip,
			mask: _mask,
			hp: data.hp,
			friction: data.friction,
			sfx_jump: LoadSound($"{global.ResourcePath}/players/{folder}/jump.ogg"),
			sfx_dash: LoadSound($"{global.ResourcePath}/players/{folder}/dash.ogg"),
			sfx_death: LoadSound($"{global.ResourcePath}/players/{folder}/death.ogg"),
			sfx_talk: LoadSound($"{global.ResourcePath}/players/{folder}/talk.ogg"),
			sfx_splash: LoadSound($"{global.ResourcePath}/players/{folder}/splash.ogg"),
			sfx_swim: LoadSound($"{global.ResourcePath}/players/{folder}/swim.ogg"),
			sfx_bonk: LoadSound($"{global.ResourcePath}/players/{folder}/bonk.ogg"),
			sfx_slide: LoadSound($"{global.ResourcePath}/players/{folder}/slide.ogg"),
			sfx_land: LoadSound($"{global.ResourcePath}/players/{folder}/land.ogg"),
			sfx_taunt: LoadSound($"{global.ResourcePath}/players/{folder}/taunt.ogg"),
			sfx_footsteps: _steps,
			anim_idle: data.anim_idle,
			anim_run: data.anim_run,
			anim_quickturn: data.anim_quickturn,
			anim_stop: data.anim_stop,
			anim_jump: data.anim_jump,
			anim_midair_up: data.anim_midair_up,
			anim_midair_down: data.anim_midair_down,
			anim_bonk: data.anim_bonk,
			anim_land: data.anim_land,
			anim_slowturn: data.anim_slowturn,
			anim_crouch_begin: data.anim_crouch_begin,
			anim_crouch_idle: data.anim_crouch_idle,
			anim_crawl: data.anim_crawl,
			anim_crouch_end: data.anim_crouch_end,
			anim_swim_up: data.anim_swim_up,
			anim_swim_down: data.anim_swim_down,
			anim_stun: data.anim_stun,
			anim_taunt: data.anim_taunt,
			jump_delay: data.jump_delay,
			bonk_delay: data.bonk_delay,
			taunt_bg: _taunt_bg
		}
		
		return output
	}
	
}

function ChatData(_data, _folder) constructor{
	
	expressions = ChatData.GetExpressions(_data, _folder)
	script = ChatData.Parse(_data);
	ingame = _data.ingame
	fails = _data.fails
	
	static Parse = function(data)
	{
		var _script = data.script
		
		return _script
	}
	
	static GetExpressions = function(data, folder)
	{
		var _expressions = data.expressions
		
		var _output = {}
		
		var keys = variable_struct_get_names(_expressions)
		for(var i = array_length(keys)-1; i >= 0; i--){
			var k = keys[i]
			var frames = _expressions[$ k].frames
			var img = LoadImage($"{global.ResourcePath}/levels/{folder}/images/{_expressions[$ k].image}", frames)
			
			var e = {}
			struct_set(e, "image", img)
			struct_set(e, "frames", frames)
			struct_set(_output, keys[i], e)
		}
		
		return _output
	}
}

function LoadImage(path, subimages=1){
	var sprite = sprite_add(path, subimages, false, false, 0, 0)
	
	return sprite
}

function LoadSound(path){
	var sound = audio_create_stream(path)
	
	return sound
}