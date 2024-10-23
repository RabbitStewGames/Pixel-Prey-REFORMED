function Options_Init(){
	global.options = {
		keymap: {
			left: ord("A"),
			right: ord("D"),
			jump: vk_space,
			dash: vk_shift,
			duck: ord("S"),
			up: ord("W")
		},
		volume: {
			master: 1,
			music: .5,
			ambience: .8,
			sfx: 1
		},
		fullscreen: false
	}
	
	Options_Save()
}

function Options_Save(){
	var jstring = json_stringify(global.options, false)
	var file = file_text_open_write($"{program_directory}options.cfg")
	file_text_write_string(file, jstring)
	file_text_close(file)
}

function Options_Load(){
	var file = file_text_open_read($"{program_directory}options.cfg")
	var jstring = file_text_read_string(file)
	var data = json_parse(jstring)
	global.options = data
	file_text_close(file)
}

function Options_Exists(){
	return file_exists($"{program_directory}options.cfg")	
}

function UpdateWindow(newScale, fullscreen){
	if(!fullscreen)
	{
		window_set_size(global.GameWidth * newScale, global.GameHeight * newScale)	
		global.GameScale = newScale
		display_set_gui_size(global.GameWidth * newScale, global.GameHeight * newScale)
	
		window_set_showborder(true)
		window_center()
	}
	else
	{
		global.GameScale = display_get_width() / global.GameWidth
		window_set_size(display_get_width(), display_get_height())	
		display_set_gui_size(display_get_width(), display_get_height())
		window_set_position(0,0)
		window_set_showborder(false)
	}
	
	global.fullscreen = fullscreen
	
	if(instance_exists(obj_view))
		obj_view.Reset()
		
	if(instance_exists(obj_lightmanager))
		obj_lightmanager.Reset()
}