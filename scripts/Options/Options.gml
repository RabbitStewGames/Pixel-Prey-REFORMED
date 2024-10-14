gml_pragma("global", "Options_Init()")

function Options_Init(){
	global.keymap = {
		left: vk_left,
		right: vk_right,
		jump: vk_space,
		dash: vk_shift,
		duck: vk_down,
		up: vk_up
	}
}

function UpdateWindow(newScale){
	window_set_size(global.GameWidth * newScale, global.GameHeight * newScale)	
	global.GameScale = newScale
	display_set_gui_size(global.GameWidth * newScale, global.GameHeight * newScale)
	
	window_center()
	
	if(instance_exists(obj_view))
		obj_view.Reset()
		
	if(instance_exists(obj_lightmanager))
		obj_lightmanager.Reset()
}