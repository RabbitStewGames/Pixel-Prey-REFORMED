gml_pragma("global", "LoadContent()")

function LoadContent()
{
	
	global.ResourcePath = $"{program_directory}resources"
	
	global.level_list = []
	global.player_list = []
	
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
		
			var _s_idle = LoadImage($"{global.ResourcePath}/levels/{levelfolder}/images/idle.png", data.images.idle_frames)
			//var _s_talk = LoadImage($"{global.ResourcePath}/levels/{levelfolder}/images/{data.leveldata.s_idle}")
			//var _s_tease = LoadImage($"{global.ResourcePath}/levels/{levelfolder}/images/{data.leveldata.s_idle}")
			var _s_acid = LoadImage($"{global.ResourcePath}/levels/{levelfolder}/images/acid.png", data.images.acid_frames)
			var _background_interior = LoadImage($"{global.ResourcePath}/levels/{levelfolder}/images/bg_interior.png")
			
			var tileImg = LoadImage($"{global.ResourcePath}/levels/{levelfolder}/images/tileset.png")
			
			var _stages = []
			
			var img_name = file_find_first($"{global.ResourcePath}/levels/{levelfolder}/progen/*", fa_none);

			while (img_name != "")
			{
				if(string_ends_with(img_name, ".png"))
				{
					var img = LoadImage(img_name)
				
					array_push(_stages, img);
				}
			    img_name = file_find_next();
			}

			file_find_close();
			
			var output = {
				directory: levelfolder,
				levelname: _levelname,
				predname: _predname,
				music: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/audio/music.ogg"),
				music_muffled: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/audio/music_muffled.ogg"),
				s_idle: _s_idle,
				s_acid: _s_acid,
				acid_speed: data.leveldata.acid_speed,
				animation_delay: data.images.animation_delay,
				acid_color: data.images.acid_color,
				acid_alpha: data.images.acid_alpha,
				ambient_light: data.images.ambient_light,
				background_interior: _background_interior,
				sfx_talk: LoadSound($"{global.ResourcePath}/levels/{levelfolder}/audio/talk.ogg"),
				tileset: tileImg,
				stages: _stages
			}
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
		
		var cd = new ChatData(d)
		
		return cd
	}
	
}

function PlayerData(_data, _folder) constructor{

	playerdata = PlayerData.Parse(_data, _folder);

	static Parse = function(data, folder)
	{
		var strip = LoadImage($"{global.ResourcePath}/players/{folder}/main_sprite.png",15)
		sprite_set_offset(strip, sprite_get_width(strip) / 2, sprite_get_height(strip))
		var _mask = LoadImage($"{global.ResourcePath}/players/{folder}/mask.png")
		sprite_set_offset(_mask, sprite_get_width(_mask) / 2, sprite_get_height(_mask))
		
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
		}
		
		return output
	}
	
}

function ChatData(_data) constructor{
	
	script = ChatData.Parse(_data);
	
	static Parse = function(data)
	{
		var _script = data.script
		
		return _script
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

function LoadStage(tilemap, index)
{
	var lvl = global.level_list[global.ACTIVE_LEVEL]
	
	var img = lvl.leveldata.stages[index]
	
	var surf = surface_create(24, 64)
	draw_clear(c_navy)
	surface_set_target(surf)
	draw_sprite(img, 0, 0, 0)
	
	for(var _x = 0; _x < 24; _x++)
	{
		for(var _y = 0; _y < 64; _y++)
		{
			if(surface_getpixel(surf, x,y) == c_white)
				tilemap_set(tilemap, tile_index_mask, _x, _y)
		}
	}
}